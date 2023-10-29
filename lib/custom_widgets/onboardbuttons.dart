import 'package:flora/screens/login.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';

class ButtonsForOnboarding extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;

  const ButtonsForOnboarding({super.key, 
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 212,
          height: 47,
          margin: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
            ),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Dosis',
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
        Container(
          width: 212,
          height: 47,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: TextButton(
            onPressed: () {
              // Button 2 onPressed action
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>  LoginScreen(), // Navigate to LoginScreen
              ));
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Dosis',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
