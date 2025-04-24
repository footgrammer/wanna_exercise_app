import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel {}

final loginViewModel = Provider.autoDispose((ref) {
  return LoginViewModel();
});
