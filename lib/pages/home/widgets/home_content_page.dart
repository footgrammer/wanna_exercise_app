import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/home/widgets/build_activity_button.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // 현재 위치
            Column(
              children: const [
                Text('현 위치 ▼', style: TextStyle(fontSize: 14)),
                SizedBox(height: 4),
                Text(
                  '서울특별시 용산구',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            // 로고 이미지 (운동하실?)
            Image.asset(
              'assets/images/wanna_exercise.png',
              width: 300,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: const Text(
                '운동 메이트를 모집해보세요!',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            // 카테고리 버튼들
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BuildActivityButton(
                    label: '축구',
                    textColor: Colors.blue,
                    bgColor: Colors.white,
                    icon: Icons.sports_soccer,
                  ),
                  BuildActivityButton(
                    label: '풋살',
                    textColor: Colors.white,
                    bgColor: Colors.blue,
                    icon: Icons.sports_soccer,
                  ),
                  BuildActivityButton(
                    label: '러닝',
                    textColor: Colors.white,
                    bgColor: Colors.orange,
                    icon: Icons.directions_run,
                  ),
                  BuildActivityButton(
                    label: '농구',
                    textColor: Colors.white,
                    bgColor: Colors.teal,
                    icon: Icons.sports_basketball,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
