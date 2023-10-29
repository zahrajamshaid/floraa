
import 'package:flora/custom_widgets/onboardbuttons.dart';
import 'package:flora/screens/signup.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
  

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: Stack( // Use Stack to layer content
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenHeight*0.5,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      width: double.infinity,
                      height:  screenHeight*0.5,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          'lib/images/onboard3.png',
                          width: double.infinity,
                          height: screenHeight * 0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.33,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                       SizedBox(height: screenHeight*0.04),
                          const Text(
                            "Congratulations!",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Dosis',
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkTextColor,
                            ),
                          ),
                         const SizedBox(height: 30,),
                           
                        const Padding(
  padding: EdgeInsets.symmetric(horizontal: 70), // Adjust left and right padding
  child: Center(
    child: Text(
      "You're now equipped with the tools and knowledge to explore the world of plants with Flora. Start your botanical journey by tapping 'Get Started' to begin identifying and learning about the incredible flora around you.",
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'Dosis',
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextColor, // Use AppColors.darkTextColor
      ),
      textAlign: TextAlign.center, // Center-align the text
    ),
  ),
),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Positioned buttons above the content
            Positioned(
              bottom: screenHeight * 0.03,
              left: 0, // Adjust the left position as needed
              right: 0, // Adjust the right position as needed
              child: ButtonsForOnboarding(
                buttonText: "Let's get Started",
                onPressed: () {
  // Navigate to the next onboarding screen
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const SignupScreen(), // Replace with the next screen
    ),
  );
},
              ),
            ),
          ],
        ),
      ),
    );
  }
}