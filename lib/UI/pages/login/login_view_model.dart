import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/model/repository/user_repository.dart';

class LoginViewModel {
  bool login({
    required String id,
    required String password,
    required GlobalKey<FormState> formKey,
  }) {
    if (formKey.currentState?.validate() ?? false) {
      final userRepository = UserRepository();
      return userRepository.login(id, password);
    } else
      return false;
  }
}

final loginViewModel = Provider.autoDispose((ref) {
  return LoginViewModel();
});
