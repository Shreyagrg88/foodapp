import 'package:flutter/material.dart';
import 'onboarding/onboardingpage1.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Landingpage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.white,
  body: Center(
    child: Image.asset(
      "assets/logo.png", height:320, width: 320, 
    ),
  ),
);
  }
}
