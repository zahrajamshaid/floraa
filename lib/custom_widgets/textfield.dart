import 'package:flora/theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final EdgeInsetsGeometry padding;
  final String labelText;
  final TextStyle labelTextStyle;
  final bool isPassword;
  final String? Function(String?)? validator; // Add an optional validator

  const CustomTextField({
    Key? key, // Add key here
    required this.controller,
    required this.hintText,
    this.padding = const EdgeInsets.all(10.0),
    this.labelText = "",
    this.labelTextStyle = const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.darkTextColor,
      fontFamily: 'Dosis',
    ),
    this.isPassword = false,
    this.validator, // Add the validator here
  }) : super(key: key); // Pass the key to the super constructor

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            widget.labelText,
            style: widget.labelTextStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Container(
            width: double.infinity,
            height: 55.0,
            decoration: BoxDecoration(
              color: AppColors.darkTextColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: widget.padding,
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.isPassword ? isObscureText : false,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor.withOpacity(0.4),
                  fontFamily: 'Dosis',
                  height: 2.0, // Adjust this value for vertical centering
                ),
                border: InputBorder.none,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          isObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.darkTextColor.withOpacity(0.4),
                        ),
                        onPressed: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                        },
                      )
                    : null,
              ),
              validator: widget.validator, // Utilize the provided validator
            ),
          ),
        ),
      ],
    );
  }
}
