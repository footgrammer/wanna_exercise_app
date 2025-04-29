import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart';

class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ProfileRepository _profileRepository = ProfileRepository();

  String formatPhoneAsEmail(String phone) {
    return '$phone@phone.login';
  }

  Future<UserCredential> login({
    required String phone,
    required String password,
  }) async {
    final formattedPhone = formatPhoneAsEmail(phone);
    final credential = await auth.signInWithEmailAndPassword(
      email: formattedPhone,
      password: password,
    );
    await _profileRepository.checkAndCreateUserProfile(
      //수정 : 로그인시 profile 문서가 없으면 생성
      credential.user!.uid,
      phone: phone,
    );
    return credential;
  }

  Future<UserCredential> register({
    required String phone,
    required String pasword,
  }) async {
    final formattedPhone = formatPhoneAsEmail(phone);
    return auth.createUserWithEmailAndPassword(
      email: formattedPhone,
      password: phone,
    );
  }

  Future<bool> isPhoneAvailable(String phone) async {
    // authentication에 저장된 정보 말고 firestore에서 가져오기

    final snapshot =
        await FirebaseFirestore.instance
            .collection('profile')
            .where('phone', isEqualTo: phone)
            .get();
    print(snapshot.docs);
    return snapshot.docs.isEmpty;
  }
}
