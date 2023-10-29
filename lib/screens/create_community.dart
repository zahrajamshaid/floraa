import 'package:flora/controllers/newcommunity.dart';
import 'package:flora/custom_widgets/custom_button.dart';
import 'package:flora/custom_widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewCommunityScreen extends StatefulWidget {
  const NewCommunityScreen({super.key});

  @override
  _NewCommunityScreenState createState() => _NewCommunityScreenState();
}

class _NewCommunityScreenState extends State<NewCommunityScreen> {
  File? _groupPhoto;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _groupPhoto = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
    color: Colors.black, // Set the color of the back arrow to black
  ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Your community',
              style: TextStyle(
                color: Color(0xFF2C2015),
                fontFamily: 'Dosis',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
             
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle "Skip" action
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Color.fromRGBO(44, 32, 21, 0.50),
                  fontFamily: 'Dosis',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.04),
            GestureDetector(
              onTap: _getImage,
              child: _groupPhoto != null
                  ? CircleAvatar(
                      radius: screenHeight * 0.09,
                      backgroundImage: FileImage(_groupPhoto!),
                     child: SvgPicture.asset(
                      'lib/assets/camera.svg', // Replace with your SVG asset
                      color: Colors.white,
                    ),
                    )
                  : CircleAvatar(
                       radius: screenHeight * 0.09,
                      backgroundColor: Colors.grey[300],
                      child: SvgPicture.asset(
                      'lib/assets/camera.svg', // Replace with your SVG asset
                      color: Colors.black,
                    ),
                    ),
            ),
            // Add more UI elements here for creating a new group
            SizedBox(height: screenHeight * 0.04),
            Column(
              children: [
                CustomTextField(controller: CommunityControllers.communityNameController, hintText: "Community Name"),
              
          
            CustomTextField(controller: CommunityControllers.communityPurposeController, hintText: "Enter your purpose in 2 to 3 lines "),
          ] ),
          SizedBox(height: screenHeight * 0.04),
         const Text(
        'Important',
        style: TextStyle(
          color: Color(0xFF2C2015),
          fontFamily: 'Dosis',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          height: 1, // Equivalent to line-height: normal
        ),
      ),
      
       SizedBox(height: screenHeight * 0.04),
       Column(
       
        children: <Widget>[
          RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            color: Color.fromRGBO(44, 32, 21, 0.80),
            fontFamily: 'Dosis',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            height: 1, // Equivalent to line-height: normal
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0, 4),
                blurRadius: 40,
                color: Color(0xFFB38CB4),
              ),
            ],
          ),
          children: <TextSpan>[
            TextSpan(
              text:
                  'Be careful with the content you post. In case of violation of our community guidelines, we have to disable your community. We are open to feedbacks. ',
            ),
          ],
        ),
          ),
          const Text(
        'Thank you',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF2C2015),
          fontFamily: 'Dosis',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
          ),
        ],
      ),
      SizedBox(height: screenHeight * 0.04),


      CustomButton(buttonText: "Create", onPressed: (){

        //create groups
      }),
      
      
         
          ],
        ),
      ),
    );
  }
}
