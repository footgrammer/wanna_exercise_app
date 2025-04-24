import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:wanna_exercise_app/data/models/user.dart';

class AuthRepository {
  final fb_auth.FirebaseAuth auth = fb_auth.FirebaseAuth.instance;

  String formatPhoneAsEmail(String phone) {
    return '$phone@phone.login';
  }

  Future<fb_auth.UserCredential> login(User user) async {
    final formattedPhone = formatPhoneAsEmail(user.phone);
    return auth.signInWithEmailAndPassword(
      email: formattedPhone,
      password: user.password,
    );
  }
}
