import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
// user.dart 의 User 클래스가 firebase_auth내의 User 클래스와 이름이 겹쳐 firebase_auth를 다른 이름으로 호출
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/user.dart';
import 'package:wanna_exercise_app/data/repositories/auth_repository.dart';

final phoneValidationMessageProvider = StateProvider<String?>((ref) => null);

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

  Future<fb_auth.UserCredential?> register({
    required String phone,
    required String password,
  }) async {
    final user = User(phone: phone, password: password);

    try {
      return await authRepo.register(user);
    } catch (e) {
      print("에러 메세지: $e");
      return null;
    }
  }

  Future<String> isAlreadyRegistered(String phone) async {
    try {
      final result = await authRepo.isAlreadyRegistered(phone);
      if (result) {
        return "사용할 수 있는 전화번호입니다.";
      } else {
        return "사용할 수 없는 전화번호입니다.";
      }
    } catch (e) {
      print("에러 메세지: $e");
      return "오류가 발생했습니다. 나중에 다시 시도해 주세요.";
    }
  }
}

final authViewModelProvider = Provider.autoDispose((ref) {
  return AuthViewModel(AuthRepository());
});
