import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/user.dart';
import 'package:wanna_exercise_app/data/repositories/auth_repository.dart';

class LoginViewModel {
  final AuthRepository authRepo;

  LoginViewModel(this.authRepo);

  Future<void> login({
    required String phoneNumber,
    required String password,
  }) async {
    final user = User(phone: phoneNumber, password: password);
    await authRepo.login(user);
  }
}

final loginViewModelProvider = Provider.autoDispose((ref) {
  return LoginViewModel(AuthRepository());
});
