import 'package:flora/custom_widgets/onboardbuttons.dart';
import 'package:flora/screens/onboard2.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  
                  Container(
                      height: screenHeight *0.5,
                    width: double.infinity,
                    decoration: const  BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      height: screenHeight * 0.5, // Adjust the image height as needed
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(
                          child: Image.asset(
                            'lib/images/onboard.png',
                            width: double.infinity,
                            height: screenHeight*0.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.33, // Adjust the container height as needed
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      width: screenWidth * 0.9, // Adjust the container width as needed
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight*0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome to ",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035, // Adjust font size as needed
                                  fontFamily: 'Dosis',
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkTextColor,
                                ),
                              ),
                              Image.asset(
                                'lib/images/seclogo.png',
                                width: screenWidth * 0.12, // Adjust image width as needed
                                height: screenHeight * 0.065, // Adjust image height as needed
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight*0.035),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.2, 
                              right: screenWidth * 0.2// Adjust padding as needed
                            ),
                            child: Text(
                              "Your ultimate guide to discovering and identifying plants with ease! Whether you're a gardening enthusiast, a nature lover, or simply curious about the flora around you, our app is here to help. Let's embark on a journey of botanical exploration together.",
                              style: TextStyle(
                                fontSize: screenWidth * 0.025, // Adjust font size as needed
                                fontFamily: 'Dosis',
                                fontWeight: FontWeight.w400,
                                color: AppColors.darkTextColor,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.03, // Adjust the button position as needed
              left: 0,
              right: 0,
              child: ButtonsForOnboarding(
                buttonText: 'Next',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Onboarding2(),
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