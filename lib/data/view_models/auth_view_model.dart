import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/core/validator_util.dart';
import 'package:wanna_exercise_app/data/repositories/auth_repository.dart';

final phoneValidationMessageProvider = StateProvider<String?>((ref) => null);

class AuthViewModel {
  final AuthRepository authRepo;

  AuthViewModel(this.authRepo);

  Future<UserCredential?> login({
    required String phone,
    required String password,
  }) async {
    try {
      return await authRepo.login(phone: phone, password: password);
    } catch (e) {
      print("에러 메세지: $e");
      return null;
    }
  }

  Future<UserCredential?> register({
    required String phone,
    required String password,
  }) async {
    try {
      return await authRepo.register(phone: phone, pasword: password);
    } catch (e) {
      print("에러 메세지: $e");
      return null;
    }
  }

  ValidatorUtil validatorUtil = ValidatorUtil();

  Future<bool?> isPhoneAvailable(String phone) async {
    try {
      String? value = validatorUtil.registerValidatorPhone(phone);
      if (value == null) {
        final result = await authRepo.isPhoneAvailable(phone);
        return result;
      }
      return null;
    } catch (e) {
      print("에러 메세지: $e");
      return null;
    }
  }
}

final authViewModelProvider = Provider.autoDispose((ref) {
  return AuthViewModel(AuthRepository());
});
