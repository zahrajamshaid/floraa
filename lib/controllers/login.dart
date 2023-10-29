import 'package:flutter/material.dart';

// Create controllers for various fields
final TextEditingController emailLoginController = TextEditingController();
final TextEditingController passwordLoginController = TextEditingController();

// Dispose of the controllers when they are no longer needed
void disposeControllers() {
  emailLoginController.dispose();
  passwordLoginController.dispose();
}
