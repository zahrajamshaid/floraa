import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora/change_notifiers/user_provider.dart';

import 'package:flora/controllers/login.dart';
import 'package:flora/custom_widgets/custom_button.dart';

import 'package:flora/custom_widgets/textfield.dart';
import 'package:flora/screens/dashboard.dart';

import 'package:flora/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flora/theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
 Future<bool> loginUser(BuildContext context) async {
  try {
    final String email = emailLoginController.text.trim();
    final String password = passwordLoginController.text.trim();

    // Step 1: Authenticate the user with Firebase Authentication

    // Step 2: Check if the user's email and password exist in Firestore
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final QuerySnapshot querySnapshot = await usersCollection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    // Step 3: If a document with matching email and password is found, consider it a successful login
    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      // If no matching document is found, log out the user and return false
      await FirebaseAuth.instance.signOut();
      return false;
    }
  } catch (error) {
    // Handle login errors and show a dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Error'),
          content: Text('There was an error during login. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    return false;
  }
}
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      
        resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
         
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Container with Gradient Background and Logo
            Container(
              width: double.infinity,
              height: screenHeight * 0.37,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.1), // Adjust the radius as needed
                  bottomRight: Radius.circular(screenWidth * 0.1), // Adjust the radius as needed
                ),
              ),
              child: Container(
                width: screenWidth * 0.2, // Width using screen percentage
                height: screenHeight * 0.12, // Height using screen percentage
                child: Image.asset('lib/images/logo.png'), // Replace with your logo image
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.07), // Space before the "Welcome Back!" text
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: screenHeight * 0.02, // Font size based on screen height
                      fontFamily: 'Dosis',
                      fontWeight: FontWeight.w500, // Adjust the fontWeight as needed
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02), // Space before the second text
                  Text(
                    "Please provide your credentials to login to the app.",
                    style: TextStyle(
                      fontSize: screenHeight * 0.02, // Font size based on screen height
                      fontFamily: 'Dosis',
                      fontWeight: FontWeight.w500, // Adjust the fontWeight as needed
                      color: AppColors.lightTextColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  CustomTextField(
                    controller: emailLoginController,
                    hintText: "Enter Email/ User ID",
                    // Optional label text
                  ),
                  CustomTextField(
                    controller: passwordLoginController,
                    hintText: "Enter Password",
                    isPassword: true,
                    // Optional label text
                  ),
                  SizedBox(height: screenHeight * 0.1),
                 
                 CustomButton(
  buttonText: 'Login',
  onPressed: () async {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailLoginController.text.trim(),
        password:  passwordLoginController.text.trim(),
      );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    // Attempt to log in
    final bool loginSuccessful = await userProvider.login(emailLoginController.text, passwordLoginController.text);

    if (loginSuccessful) {
      // Navigate to the home screen after successful login
    
userProvider.fetchUsername();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      // Handle login failure (show an error message, etc.)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Error'),
            content: Text('There was an error  during login. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  },
),

                  SizedBox(height: screenHeight * 0.01), // Space before the second text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          fontFamily: 'Dosis',
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightTextColor,
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            // Handle the tap gesture for "Signup" here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(), // Replace with your Signup page
                              ),
                            );
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: screenHeight * 0.02,
                              fontFamily: 'Dosis',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
