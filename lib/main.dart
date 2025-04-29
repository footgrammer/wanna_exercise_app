import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/firebase_options.dart';
import 'package:wanna_exercise_app/pages/home/widgets/home_content_page.dart';
import 'package:wanna_exercise_app/pages/login/login_page.dart';
import 'package:wanna_exercise_app/pages/board/create_post_page.dart';
import 'package:wanna_exercise_app/pages/profile/profile_page.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';
import 'package:wanna_exercise_app/pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterNaverMap().init(
    clientId: "ddmiypldvb",
    onAuthFailed: (ex) {
      print(ex);
    },
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        return MaterialApp(
          title: 'Wanna Exercise App',
          theme: appTheme,
          home:
              user == null
                  ? LoginPage()
                  : LoginPage(), // 테스트 위해 홈페이지 바꾸는 경우 여기서 HomePage()만 바꿔 주세요
        );
      },
    );
  }
}
