import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wanna_exercise_app/data/models/profile.dart';

class ProfileRepository {
  ProfileRepository();

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // 최초 로그인 시, 프로필 문서가 없으면 생성하는
  Future<void> checkAndCreateUserProfile(String uid, {String? phone}) async {
    final docRef = _firestore.collection('profile').doc(uid);
    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      await docRef.set({
        'nickname': '김운동',
        'phone': phone ?? '010-0000-0000',
        'profileImage': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // 작성되어 있던 코드
  Future<List<Profile>> getAll() async {
    final collectionRef = _firestore.collection('user');
    final snapshot = await collectionRef.get();
    final documentSnapshots = snapshot.docs;

    return documentSnapshots.map((e) {
      final map = {...e.data()};
      return Profile.fromJson(map);
    }).toList(); // Profile 전체 리스트 반환
  }

  // 추가함 : 특정 유저 프로필 가져오기
  Future<Profile?> getProfile(String uid) async {
    final doc = await _firestore.collection('profile').doc(uid).get();
    if (!doc.exists) return null;
    return Profile.fromJson(doc.data()!);
  }

  // 추가함 : 프로필 이미지 업로드 및 URL Firestore에 저장
  Future<String> uploadProfileImage(String uid, File file) async {
    final ref = _storage.ref().child('profiles/$uid.jpg');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();

    await _firestore.collection('profile').doc(uid).update({
      'profileImage': url,
    });

    return url;
  }

  //추가함 : 닉네임 업데이트
  Future<void> updateNickname(String uid, String nickname) async {
    await _firestore.collection('profile').doc(uid).update({
      'nickname': nickname,
    });
  }

  //추가함 : 닉네임, 이미지 URL 동시 업데이트
  Future<void> updateProfile({
    required String uid,
    String? nickname,
    String? profileImageUrl,
  }) async {
    final data = <String, dynamic>{};
    if (nickname != null) data['nickname'] = nickname;
    if (profileImageUrl != null) data['profileImage'] = profileImageUrl;

    await _firestore.collection('profile').doc(uid).update(data);
  }

  Future<List<Map<String, String>>> getUserUidsWithNicknames() async {
    try {
      // Firestore에서 프로필 컬렉션을 가져오기
      final collectionRef = _firestore.collection('profile');
      final snapshot = await collectionRef.get();
      final documentSnapshots = snapshot.docs;

      // UID와 닉네임을 매핑한 리스트 생성
      List<Map<String, String>> userUidsWithNicknames = [];

      for (var doc in documentSnapshots) {
        final data = doc.data();
        final uid = doc.id; // 문서의 ID는 UID
        final nickname =
            data['nickname'] ?? 'No Name'; // 닉네임을 가져오고 없으면 'No Name'을 기본값으로 설정

        userUidsWithNicknames.add({'uid': uid, 'nickname': nickname});
      }

      return userUidsWithNicknames;
    } catch (e) {
      throw Exception("프로필을 불러오는 데 실패했습니다: $e");
    }
  }
}
