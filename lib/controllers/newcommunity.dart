import 'package:flutter/material.dart';

class CommunityControllers {
  static final TextEditingController communityNameController = TextEditingController();
  static final TextEditingController communityPurposeController = TextEditingController();

  // Dispose of the controllers to release resources
  void dispose() {
    communityNameController.dispose();
    communityPurposeController.dispose();
  }
}
