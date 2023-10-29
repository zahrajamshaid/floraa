 import 'package:flora/screens/community.dart';
import 'package:flora/screens/dashboard.dart';
import 'package:flora/screens/profile.dart';
import 'package:flora/screens/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class BottomBar extends StatefulWidget {
  const BottomBar({super.key});



  @override
  State<BottomBar> createState() => _BottomBarState();
}class _BottomBarState extends State<BottomBar> {
  int _pageIndex = 0;
  final List<Widget> _tabList = [
    const HomeScreen(),
    const ScannerScreen(),
    const CommunityScreen(),
    const ProfileScreen(),
  ];

  // Define your color variables here
  final selectedColor = const Color(0xFF6AB29C); // Selected item color
  final unselectedColor = const Color.fromRGBO(149, 135, 122, 128); // Unselected item color

  void _onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
    // Use Navigator to navigate to the selected screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => _tabList[index],
      ),
    );
  }

  Widget _buildIcon(int iconIndex, String assetPath) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 80.0, // Adjust the size of the circle as needed
            height: 57.0, // Adjust the size of the circle as needed
            decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(30.0),
              color: _pageIndex == iconIndex ? selectedColor : Colors.transparent,
            ),
            child: SvgPicture.asset(
              assetPath,
              color: _pageIndex == iconIndex ? Colors.white : unselectedColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: const Color.fromRGBO(149, 135, 122, 128),
              ),
              borderRadius: BorderRadius.circular(80.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: BottomNavigationBar(
                selectedItemColor: selectedColor,
                unselectedItemColor: unselectedColor,
                backgroundColor: Colors.transparent,
                currentIndex: _pageIndex,
                onTap: _onTabTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: _buildIcon(0, 'lib/assets/home.svg'),
                    label: ' ',
                  ),
                  BottomNavigationBarItem(
                    icon: _buildIcon(1, 'lib/assets/scanner.svg'),
                    label: ' ',
                  ),
                  BottomNavigationBarItem(
                    icon: _buildIcon(2, 'lib/assets/community.svg'),
                    label: ' ',
                  ),
                  BottomNavigationBarItem(
                    icon: _buildIcon(3, 'lib/assets/profile.svg'),
                    label: ' ',
                  ),
                ],
                selectedLabelStyle: const TextStyle(fontSize: 0.0),
                unselectedLabelStyle: const TextStyle(fontSize: 0.0),
              ),
            ),
          ),
        );
      },
    );
  }
}