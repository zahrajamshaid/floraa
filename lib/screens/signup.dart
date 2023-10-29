import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora/change_notifiers/user_provider.dart';
import 'package:flora/controllers/signup.dart';
import 'package:flora/custom_widgets/custom_button.dart';
import 'package:flora/custom_widgets/textfield.dart';

import 'package:flora/models/user.dart';
import 'package:flora/screens/dashboard.dart';
import 'package:flora/screens/login.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool passwordsMatch = true;
  bool registerationSuccessful = true;
  final _auth = FirebaseAuth.instance;
 void register() async {
  final String email = UserController.emailSignupController.text.trim();
  final String password = UserController.passwordSignupController.text.trim();

  // Show the loading indicator while registering
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false); // Access the UserProvider instance
    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final UserModel newUser = UserModel(
      uid: userCredential.user!.uid,
      username: UserController.usernameController.text.trim(),
      email: email,
    );

    // Store user information in Firestore
    await FirebaseFirestore.instance
        .collection("users")
        .doc(newUser.uid)
        .set(newUser.toJson());

    // Call fetchUsername to fetch the username after registration
    await userProvider.fetchUsername();

    // Registration successful, update the state or show a success message
    setState(() {
      registerationSuccessful = true;
    });

    // Close the loading indicator dialog
    Navigator.pop(context);

    // Show a success message and navigate to the HomeScreen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered. You may login now'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(), // Navigate to HomeScreen
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (error) {
    // Registration failed, log the error and set registrationSuccessful to false
    setState(() {
      registerationSuccessful = false;
    });

    // Close the loading indicator dialog
    Navigator.pop(context);

    // Show a failure message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed'),
          content: const Text('Registration failed. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  bottomLeft: Radius.circular(screenWidth * 0.1),
                  bottomRight: Radius.circular(screenWidth * 0.1),
                ),
              ),
              child: SizedBox(
                width: screenWidth * 0.2,
                height: screenHeight * 0.12,
                child: Image.asset('lib/images/logo.png'),
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.07,
                  ),
                  Text(
                    "Welcome! ",
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontFamily: 'Dosis',
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "Please provide the details below",
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontFamily: 'Dosis',
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightTextColor,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  CustomTextField(
                    controller: UserController.usernameController,
                    hintText: "Enter User ID",
                  ),
                  CustomTextField(
                    controller: UserController.emailSignupController,
                    hintText: "Enter Email",
                    // Set this to true for password fields
                   
                  ),
                  CustomTextField(
                    controller: UserController.
                        passwordSignupController,
                    hintText: "Enter Password",
                    isPassword: true, // Set this to true for password fields
                     
                  ),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By pressing Signup you agree to our ",
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          fontFamily: 'Dosis',
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle the tap gesture for "Term and Conditions" here
                          // You can navigate to the terms and conditions screen or show a dialog.
                          // Example: Navigator.push(...);
                        },
                        child: Text(
                          "Term and Conditions",
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontFamily: 'Dosis',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  CustomButton(
                    buttonText: 'Signup',
                    onPressed: () => register(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          fontFamily: 'Dosis',
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightTextColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontFamily: 'Dosis',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
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
