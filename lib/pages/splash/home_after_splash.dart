import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/home/home_page.dart';
import 'package:wanna_exercise_app/pages/login/login_page.dart';

class HomeAfterSplash extends StatefulWidget {
  final AsyncSnapshot<User?> snapshot;
  const HomeAfterSplash({super.key, required this.snapshot});

  @override
  State<HomeAfterSplash> createState() => HomeAfterSplashState();
}

class HomeAfterSplashState extends State<HomeAfterSplash>
    with SingleTickerProviderStateMixin {
  bool showSplash = true;
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    startSplashTimer();
    controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
  }

  // 3초 딜레이
  void startSplashTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      await controller.forward();
      setState(() {
        showSplash = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.snapshot.data;
    final Widget targetPage = user == null ? LoginPage() : HomePage();

    return Stack(
      children: [
        // 메인 화면을 아래에 미리 로드해둠
        targetPage,

        if (showSplash)
          FadeTransition(
            opacity: fadeAnimation,
            child: Scaffold(
              backgroundColor: Color(0xFFE5E5E5),
              body: Center(
                child: Image.asset('assets/images/wanna_exercise.png'),
              ),
            ),
          ),
      ],
    );
  }
}
