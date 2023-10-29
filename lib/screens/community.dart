import 'package:flora/custom_widgets/explore.dart';
import 'package:flora/custom_widgets/my_communites.dart';
import 'package:flora/custom_widgets/search_bar.dart';
import 'package:flora/screens/chat.dart';
import 'package:flora/screens/create_community.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flora/custom_widgets/new_bottom_navbar.dart';
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height:  screenHeight* 0.9,
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(),
                  const Center(
                    child: Text(
                      'What have you been looking for?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontFamily: 'Dosis',
                      ),
                    ),
                  ),
                  Center(child:ElevatedButton(
                    //create new group 
                     onPressed: () { Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => 
            NewCommunityScreen(),
            )); },
      
    
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(15),
        ),
                     child: const Text(
        "Create your Community",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Dosis',
            color: Color(0xFFFFFFFF),
          ),
        ),
       
      )),



                
                  Text(
                    'My Communities',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 17.sp,
                      fontFamily: 'Dosis',
                    ),
                  ),
                Center(
  child: SizedBox(
    height: screenHeight * 0.15, // Adjust the height as needed
    //display the joined groups 
    child: ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 3, // Replace with the actual number of items
      shrinkWrap: true, // Set shrinkWrap to true
      itemBuilder: (context, index) {
        return CommunityButton(
  communityName: "Indoor Plants",
  dateOfCreation: "1/11/2023",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(),
      ),
    );
  },
  groupIcon: const Icon(Icons.group), // You can provide a group icon here
)
;
      },
    ),
  ),
),

                  Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 17.sp,
                      fontFamily: 'Dosis',
                    ),
                  ),
                SizedBox(
  height: screenHeight * 0.18,
  width: screenWidth,
  // Display all available grounps 
  child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: 5, // Replace with the actual number of items
    separatorBuilder: (context, index) => const SizedBox(width: 20.0), // Adjust the gap width as needed
    itemBuilder: (context, index) {
      return Explore(communityName: "Indoor Plants", onPressed: () {

        
      });
    },
  ),
),

                  Center(
                    child: Text(
                      'Explore More',
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15.sp,
                        fontFamily: 'Dosis',
                      ),
                    ),
                  ),
          
               
                ],
              ),
            ),
          ),
        ),
     bottomNavigationBar: Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      
      child: const BottomBar()),
     
     
      );
    });
  }
}
