import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
// user.dart 의 User 클래스가 firebase_auth내의 User 클래스와 이름이 겹쳐 firebase_auth를 다른 이름으로 호출
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

  Future<fb_auth.UserCredential> register(User user) async {
    final formattedPhone = formatPhoneAsEmail(user.phone);
    return auth.createUserWithEmailAndPassword(
      email: formattedPhone,
      password: user.password,
    );
  }
}
