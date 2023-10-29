import 'package:flutter/material.dart';

class PlantOfTheDay extends StatelessWidget {
  final String imageUrl;
  final String firstText;
  final String secondText;

  const PlantOfTheDay({
    required this.imageUrl,
    required this.firstText,
    required this.secondText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.16,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(149, 135, 122, 128),
        borderRadius: BorderRadius.all(
          Radius.circular(screenWidth * 0.05),
        ),
      ),
      alignment: Alignment.topCenter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -65, // Adjust this value for your desired positioning
            child: Transform.translate(
              offset: const Offset(0.0, -45.0), // Adjust this offset for your desired positioning
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  firstText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Dosis',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  secondText,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.50),
                    fontFamily: 'Dosis',
                    fontSize: 14,
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
    );
  }
}
