import 'package:flora/theme.dart';
import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  final String communityName;
  final VoidCallback onPressed;
  final Icon? communityIcon; // Optional community icon

  const Explore({super.key, required this.communityName, required this.onPressed, this.communityIcon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final buttonWidth = screenWidth * 0.4; // Adjust the factor as needed
  
    return SizedBox(
      width: buttonWidth,
      height: 95,
  
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
     
        ),
        child: Column( // Use Column to align items vertically
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (communityIcon != null)
              CircleAvatar( // Use CircleAvatar for displaying the community icon
                radius: 20, // Adjust the radius as needed
                backgroundColor: Colors.black, // Replace with your community icon
                child: communityIcon,
              ),
            if (communityIcon == null)
              const CircleAvatar( // Use CircleAvatar for displaying the default icon
                radius: 15, // Adjust the radius as needed
                backgroundColor: Colors.black, // Replace with your default icon
                child: Icon(Icons.group, size: 30, color: Colors.white),
              ),
            // Add space between icon and text
            Text(
              communityName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Dosis',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 3),
           Align(
            alignment: Alignment.bottomRight,
             child: ElevatedButton(
                   onPressed: onPressed,
                   style: ElevatedButton.styleFrom(
                     backgroundColor: AppColors.primaryButton,
                     shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
                     ),
                     padding: const EdgeInsets.all(10),
                   ),
                   child: const Text(
                   "Join",
                     textAlign: TextAlign.center,
                     style: TextStyle(
              fontSize: 14,
              fontFamily: 'Dosis',
              color: Color(0xFFFFFFFF),
                     ),
                   ),
                 ),
           ), // Add space between text and button
          ],
        ),
      ),
    );
  }
}
