import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
// user.dart 의 User 클래스가 firebase_auth내의 User 클래스와 이름이 겹쳐 firebase_auth를 다른 이름으로 호출
import 'package:wanna_exercise_app/data/models/user.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart';

class AuthRepository {
  final fb_auth.FirebaseAuth auth = fb_auth.FirebaseAuth.instance;
  final ProfileRepository _profileRepository = ProfileRepository();

  String formatPhoneAsEmail(String phone) {
    return '$phone@phone.login';
  }

  Future<fb_auth.UserCredential> login(User user) async {
    final formattedPhone = formatPhoneAsEmail(user.phone);
    final credential = await auth.signInWithEmailAndPassword(
      email: formattedPhone,
      password: user.password,
    );
    await _profileRepository.checkAndCreateUserProfile( //수정 : 로그인시 profile 문서가 없으면 생성
      credential.user!.uid,
      phone: user.phone,
    );
    return credential;
  }

  Future<fb_auth.UserCredential> register(User user) async {
    final formattedPhone = formatPhoneAsEmail(user.phone);
    return auth.createUserWithEmailAndPassword(
      email: formattedPhone,
      password: user.password,
    );
  }
}
