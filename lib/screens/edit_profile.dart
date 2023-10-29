import 'dart:io';
import 'package:flora/change_notifiers/user_provider.dart';
import 'package:flora/custom_widgets/custom_button.dart';
import 'package:flora/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
   
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _profilePhoto;
late String uid;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

 // Load the user data from the UserProvider
  void loadUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    UserModel? currentUser = await userProvider.getCurrentUserData();

    if (currentUser != null) {
      // Set the text fields with the user's data
      setState(() {
        usernameController.text = currentUser.username;
        emailController.text = currentUser.email;
        locationController.text = currentUser.location;
        phoneNumberController.text = currentUser.phoneNumber;
      });
    }
  }
  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePhoto = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                GestureDetector(
                  onTap: _getImage,
                  child: _profilePhoto != null
                      ? CircleAvatar(
                          radius: screenHeight * 0.09,
                          backgroundImage: FileImage(_profilePhoto!),
                          child: SvgPicture.asset(
                            'lib/assets/camera.svg',
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          radius: screenHeight * 0.09,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                            'lib/assets/camera.svg',
                            color: Colors.black,
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 135,
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color.fromRGBO(44, 32, 21, 0.50),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('lib/assets/edit-profile.svg'),
                      const SizedBox(width: 8),
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Color(0xFF2C2015),
                          fontFamily: 'Dosis',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("User Name", usernameController),
                _buildTextField("Location", locationController),
                _buildTextField("Email Id", emailController),
                _buildTextField("Phone Number", phoneNumberController),
              ],
            ),
            SizedBox(height: screenHeight * 0.1),
            Center(
              child: CustomButton(
                buttonText: "Save Changes",
                onPressed: () async {
                  String uid = await userProvider.getCurrentUserUid() ?? "default_uid";

                  // Create a UserModel with the updated information
                  UserModel updatedUser = UserModel(
                    uid: uid,
                    username: usernameController.text,
                    email: emailController.text,
                    location: locationController.text,
                    phoneNumber: phoneNumberController.text,
                    profilePhoto: _profilePhoto?.path ?? "", // Check if profile photo is null
                  );

                  // Call the updateUserInfo function to update the user's information
                  await userProvider.updateUserInfo(updatedUser);

                  // Navigate back to the profile screen or perform other actions as needed
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(
          label,
          style: const TextStyle(
            color: Color.fromRGBO(44, 32, 21, 0.50),
            fontFamily: 'Dosis',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        TextField(
          controller: controller,
        ),
      ],
    );
  }
}
