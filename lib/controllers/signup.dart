import 'package:flutter/material.dart';

class UserController {
  static  TextEditingController uidController = TextEditingController();

  static  TextEditingController emailSignupController = TextEditingController();
  static TextEditingController passwordSignupController = TextEditingController();
  static  TextEditingController usernameController = TextEditingController(); // Add this controller
  
  // Dispose the controllers when they are no longer needed
  void dispose() {
    uidController.dispose();
    emailSignupController.dispose();
  
    passwordSignupController.dispose();
    usernameController.dispose(); // Dispose the confirmPasswordController
  }
}


