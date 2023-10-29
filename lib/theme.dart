import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryButton = Color(0xFFCDCB14);
  static const Color backgroundColor = Color(0xFF18604A);
  static const Color accentColor = Color(0xFF6AB29C);
  static const Color darkTextColor = Color(0xFF2C2015);
  static const Color lightTextColor = Color(0xFF95877A);
  static Color appBarBackgroundColor = const Color(0xFF2C2015).withOpacity(1.0); // Fully opaque
  static Color totalMembersColor = const Color(0xFF21153B).withOpacity(0.50); // 50% opacity
  static Color leaveButtonColor = const Color(0xFF2C2015).withOpacity(0.50); // 50% opacity
  static Color usernameColor = const Color(0xFF2C2015).withOpacity(0.80); // 80% opacity
  static Color messageTextColor = const Color(0xFF2C2015).withOpacity(0.60); // 60% opacity
  static Color dateColor = const Color(0xFF2C2015).withOpacity(0.50); // 50% opacity

  static const LinearGradient gradientBackground = LinearGradient(
              begin: Alignment(0.04, -0.02),
              end: Alignment(1.1, 0.8),
              colors: [
                AppColors.backgroundColor,
                Color(0XFF6AB29C),
              ],
            );
}