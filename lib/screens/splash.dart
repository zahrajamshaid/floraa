import 'package:flora/screens/onboard1.dart';
import 'package:flutter/material.dart';
import 'package:flora/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 2 seconds before navigating to the main screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const Onboarding1(), // Replace with your main screen
        ),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.gradientBackground,
          ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your logo image here
              Image.asset(
                'lib/images/logo.png', // Replace with your logo image path
                width: 191, // Set your desired width
                height: 103, // Set your desired height
              ),
            ],
          ),
        ),
      ),
    );
  }
}
