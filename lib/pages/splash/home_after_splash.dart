import 'package:flutter/material.dart';

class HomeAfterSplash extends StatelessWidget {
  final Widget child;
  const HomeAfterSplash({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [child, SplashOverlay()]);
  }
}

class SplashOverlay extends StatefulWidget {
  const SplashOverlay({super.key});

  @override
  State<SplashOverlay> createState() => SplashOverlayState();
}

class SplashOverlayState extends State<SplashOverlay>
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
    if (!showSplash) return const SizedBox.shrink();
    return FadeTransition(
      opacity: fadeAnimation,
      child: Scaffold(
        backgroundColor: const Color(0xFFE5E5E5),
        body: Center(child: Image.asset('assets/images/wanna_exercise.png')),
      ),
    );
  }
}
