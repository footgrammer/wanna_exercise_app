import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
// user.dart 의 User 클래스가 firebase_auth내의 User 클래스와 이름이 겹쳐 firebase_auth를 다른 이름으로 호출
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/user.dart';
import 'package:wanna_exercise_app/data/repositories/auth_repository.dart';

class AuthViewModel {
  final AuthRepository authRepo;

  AuthViewModel(this.authRepo);

  Future<fb_auth.UserCredential?> login({
    required String phone,
    required String password,
  }) async {
    final user = User(phone: phone, password: password);
    try {
      return await authRepo.login(user);
    } catch (e) {
      print("에러 메세지: $e");
      return null;
    }
  }
}

final authViewModelProvider = Provider.autoDispose((ref) {
  return AuthViewModel(AuthRepository());
});
