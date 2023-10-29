
import 'package:flora/custom_widgets/ellipse.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CustomContainer extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;


  const CustomContainer({super.key, 
    required this.screenWidth,
    required this.screenHeight,
   
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.37,
      child: Stack(
        children: [
          // Background Container with AppColors.backgroundColor
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(screenWidth * 0.1),
                bottomRight: Radius.circular(screenWidth * 0.1),
              ),
            ),
            child: Center(
              child: SizedBox(
                width: screenWidth * 0.2,
                height: screenHeight * 0.12,
                child: Image.asset('lib/images/logo.png'), // Replace with your logo image
              ),
            ),
          ),
          // Top Left Ellipse with Blur
          Positioned(
            left: 10, // Adjust the position as needed
            top: 10, // Adjust the position as needed
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
              child: CustomPaint(
                size: const Size(150, 150), // Adjust the size as needed
                painter: EllipsePainter(
                  borderWidth: 0.0,
                  borderColor: Colors.transparent,
                  padding: 0.0,
                  backgroundColor: const Color(0xFF6AB29C), // #6AB29C
                ),
              ),
            ),
          ),
          // Bottom Right Ellipse with Blur
          Positioned(
            right: 3.0, // Adjust the position as needed
            bottom: 5.0, // Adjust the position as needed
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
              child: CustomPaint(
                size: const Size(150, 150), // Adjust the size as needed
                painter: EllipsePainter(
                  borderWidth: 0.0,
                  borderColor: Colors.transparent,
                  padding: 0.0,
                  backgroundColor: const Color(0xFF6AB29C), // #6AB29C
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
