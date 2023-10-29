
import 'package:flora/custom_widgets/onboardbuttons.dart';
import 'package:flora/screens/onboard3.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

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
                    height: screenHeight *0.5,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: screenHeight *0.5,
                      decoration: const BoxDecoration(
                        color:  Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          'lib/images/onboard2.png',
                          width: double.infinity,
                          height:  screenHeight*0.5,
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
                            "How it works?",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Dosis',
                              fontWeight: FontWeight.w700,
                              color: AppColors.darkTextColor,
                            ),
                          ),
                         
                        const  Padding(
                            padding: EdgeInsets.only(left: 50, right: 50, top: 15),
                            child:Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ListTile(
      dense: true, // Use dense to reduce spacing
      contentPadding: EdgeInsets.only(left: 12), // Adjust contentPadding
      visualDensity: VisualDensity(horizontal: -4, vertical: -4), // Adjust visualDensity
      leading: Icon(
        Icons.fiber_manual_record,
        size: 8,
        color: AppColors.darkTextColor, // Use AppColors.darkTextColor
      ),
      title: Text(
        "Step 1: Tap the camera icon to take a photo of a plant.",
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Dosis',
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextColor, // Use AppColors.darkTextColor
        ),
      ),
    ),
    ListTile(
      dense: true, // Use dense to reduce spacing
      contentPadding: EdgeInsets.only(left: 12), // Adjust contentPadding
      visualDensity: VisualDensity(horizontal: -4, vertical: -4), // Adjust visualDensity
      leading: Icon(
        Icons.fiber_manual_record,
        size: 8,
        color: AppColors.darkTextColor, // Use AppColors.darkTextColor
      ),
      title: Text(
        "Step 2: Alternatively, select an image from your gallery that you'd like to identify.",
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Dosis',
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextColor, // Use AppColors.darkTextColor
        ),
      ),
    ),
    ListTile(
      dense: true, // Use dense to reduce spacing
      contentPadding: EdgeInsets.only(left: 12), // Adjust contentPadding
      visualDensity: VisualDensity(horizontal: -4, vertical: -4), // Adjust visualDensity
      leading: Icon(
        Icons.fiber_manual_record,
        size: 8,
        color: AppColors.darkTextColor, // Use AppColors.darkTextColor
      ),
      title: Text(
        "Step 3: Let our cutting-edge image recognition technology do the rest!",
        style: TextStyle(
          fontSize: 12,
          fontFamily: 'Dosis',
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextColor, // Use AppColors.darkTextColor
        ),
      ),
    ),
  ],
)

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
      builder: (context) => const Onboarding3(), // Replace with the next screen
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