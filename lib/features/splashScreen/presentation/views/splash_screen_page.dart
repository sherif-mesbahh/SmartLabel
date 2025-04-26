import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_label_software_engineering/features/onBoarding/presentaion/views/on_boarding_page.dart';
import 'package:smart_label_software_engineering/presentation/views/home_pages/layout.dart';

class SplashScreenPage extends StatelessWidget {
  final bool showOnBoarding;

  const SplashScreenPage({super.key, required this.showOnBoarding});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/smart_label_logo.png',
            height: 150,
          ),
        ],
      ),
      splashIconSize: 150,
      nextScreen: showOnBoarding ? const OnBoardingPage() : const Layout(),
      backgroundColor: const Color.fromARGB(255, 60, 99, 254),
      duration: 1000,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}
