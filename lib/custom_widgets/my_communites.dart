import 'package:flutter/material.dart';

class CommunityButton extends StatelessWidget {
  final String communityName;
  final String? dateOfCreation; // Updated to be an optional String
  final Icon? groupIcon; // Updated to be an optional Icon
  final VoidCallback onPressed;

  const CommunityButton({super.key, 
    required this.communityName,
    required this.onPressed,
    this.dateOfCreation,
    this.groupIcon,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.4; // Adjust the factor as needed

    return Container(
      width: buttonWidth,
      height: 47,
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
        ),
        child: Row(
          children: [
            if (groupIcon != null) // Use groupIcon if provided
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black, // Replace with your community icon
                ),
                child: groupIcon,
              ),
            if (groupIcon != null) // Add space between the icon and text if it's available
              const SizedBox(width: 10),
            Row(
            
              children: [
                Text(
                  communityName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Dosis',
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: screenWidth *0.2),
                if (dateOfCreation != null) // Display dateOfCreation if available
                  Text(
                    dateOfCreation!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Dosis',
                      color: Color.fromRGBO(44, 32, 21, 0.50),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
