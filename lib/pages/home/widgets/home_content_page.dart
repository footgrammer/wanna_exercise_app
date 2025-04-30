import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/data/view_models/home_content_view_model.dart';
import 'package:wanna_exercise_app/pages/board/create_board_page.dart';
import 'package:wanna_exercise_app/pages/home/widgets/build_activity_button.dart';
import 'package:wanna_exercise_app/pages/board/create_board_page.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final HomeContentViewModel viewModel = HomeContentViewModel();
  String currentAddress = '위치 가져오는 중...';

 @override
void initState() {
  super.initState();
  viewModel.getCurrentLocation((updatedAddress) {
    if (!mounted) return;
    setState(() {
      currentAddress = updatedAddress;
    });
  });
}


  void _navigateToCreatePost(String selectedSport) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateBoardPage(initialType: selectedSport),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                const Text('현 위치 ▼', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  currentAddress,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            Image.asset(
              'assets/images/wanna_exercise.png',
              width: 300,
              fit: BoxFit.contain,
            ),
            const Spacer(),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BuildActivityButton(
                    label: '축구',
                    textColor: Colors.white,
                    bgColor: primaryColor,
                    icon: Icons.sports_soccer,
                    onTap: () => _navigateToCreatePost('soccer'),
                  ),
                  BuildActivityButton(
                    label: '풋살',
                    textColor: Colors.white,
                    bgColor: accentColor3,
                    icon: Icons.sports_soccer,
                    onTap: () => _navigateToCreatePost('futsal'),
                  ),
                  BuildActivityButton(
                    label: '러닝',
                    textColor: Colors.white,
                    bgColor: accentColor1,
                    icon: Icons.directions_run,
                    onTap: () => _navigateToCreatePost('running'),
                  ),
                  BuildActivityButton(
                    label: '농구',
                    textColor: Colors.white,
                    bgColor: accentColor2,
                    icon: Icons.sports_basketball,
                    onTap: () => _navigateToCreatePost('basketball'),
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
