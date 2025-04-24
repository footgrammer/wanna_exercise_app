import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/home/widgets/build_activity_button.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class HomeContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BuildActivityButton(
              label: '⚽ 축구하실?', textColor: Colors.white, bgColor: Colors.blue),
          BuildActivityButton(
              label: '⚽ 풋살하실?', textColor: Colors.white, bgColor: Colors.blue[700]!),
          BuildActivityButton(
              label: '🏃 러닝하실?', textColor: Colors.white, bgColor: appTheme.colorScheme.secondary),
          BuildActivityButton(
              label: '🏀 농구하실?', textColor: Colors.white, bgColor: Colors.teal),
        ],
      ),
    );
  }
}
