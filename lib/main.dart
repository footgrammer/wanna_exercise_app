import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/firebase_options.dart';
import 'package:wanna_exercise_app/pages/splash/home_after_splash.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

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
        return MaterialApp(
          title: 'Wanna Exercise App',
          theme: appTheme,
          home: HomeAfterSplash(snapshot: snapshot),
        );
      },
    );
  }
}
