import 'package:flutter/material.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Set the background color to white
        child: Padding(
          padding: const EdgeInsets.only(left: 22),
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.asset('lib/images/seclogo.png', fit: BoxFit.cover),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 6.0),
                leading: const Icon(Icons.account_circle, color: Colors.black),
                title: const Text(
                  "My Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Handle the My Profile item tap
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                leading: const Icon(Icons.language, color: Colors.black),
                title: const Text(
                  "Change Language",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Handle the Change Language item tap
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                leading: const Icon(Icons.feedback, color: Colors.black),
                title: const Text(
                  "Feedback",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Handle the Feedback item tap
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                leading: const Icon(Icons.settings, color: Colors.black),
                title: const Text(
                  "FAQs",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Handle the FAQs item tap
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                leading: const Icon(Icons.contact_mail, color: Colors.black),
                title: const Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Handle the Contact Us item tap
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                leading: const Icon(Icons.help, color: Colors.black),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Handle the Help item tap
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                leading: const Icon(Icons.library_books, color: Colors.black),
                title: const Text(
                  "Terms and Conditions",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // Handle the Terms and Conditions item tap
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
