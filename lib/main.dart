import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wanna Exercise App',
      theme: appTheme,
      home: HomePage(),
    );
  }
}
