
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora/change_notifiers/user_provider.dart';
import 'package:flora/custom_widgets/drawer.dart';
import 'package:flora/custom_widgets/new_bottom_navbar.dart';
import 'package:flora/custom_widgets/weather_info.dart';
import 'package:flora/models/plantoftheday.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
 
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late int plantIndex; // Index for the current date
  late Plant currentPlant;

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  
    // The rest of your initState logic...

    // Initialize the index based on the current date
    plantIndex = DateTime.now().day % plantList.length;
    currentPlant = plantList[plantIndex];

    // Fetch the plant of the day initially
    // fetchPlantOfTheDay();

    // Schedule daily updates
    Timer.periodic(const Duration(days: 1), (Timer t) {
      // Update the index and current plant
      setState(() {
        plantIndex = DateTime.now().day % plantList.length;
        currentPlant = plantList[plantIndex];
      });
      // fetchPlantOfTheDay();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    String greeting = '';

    if (currentTime.hour < 12) {
      greeting = 'Good Morning';
    } else if (currentTime.hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

   
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}/${now.month}/${now.day}";

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: const SideNavigation(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.backgroundColor,
            title: Row(
              children: [

                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: TextStyle(
                        color: const Color(0x4DFFFFFF),
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        fontFamily: 'Dosis',
                      ),
                    ),
                    Text(
  context.watch<UserProvider>().username,
  style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    fontFamily: 'Dosis',
  ),
),

                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  height: 37.h,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft:  Radius.circular(10.w),
                      bottomRight: Radius.circular(10.w),
                    ),
                  ),
                  child: const WeatherInfo(),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Plant of the Day",
                        style: TextStyle(
                          fontSize: 2.8.h,
                          fontFamily: 'Dosis',
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkTextColor,
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 2.2.h,
                          fontFamily: 'Dosis',
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h, right: 25.w, left: 25.w,),
                  child: Container(
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(149, 135, 122, 128),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.w),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(0, 5),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    alignment: Alignment.topCenter,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          child: Transform.translate(
                            offset: Offset(0.0, -7.h),
                            child: Container(
                              height: 13.h,
                              width: 13.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: AssetImage('lib/images/plants/${currentPlant.commonName}.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 7.7.h, bottom: 1.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                currentPlant.commonName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Dosis',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                currentPlant.scientificName,
                                style: TextStyle(
                                  color: const Color.fromRGBO(255, 255, 255, 0.50),
                                  fontFamily: 'Dosis',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 5.2.h),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 25),
                //   child: const BottomBar(),
                // ),
              ],
            ),
          ),
       bottomNavigationBar: const BottomBar(),
        );
      },
    );
  }
}
