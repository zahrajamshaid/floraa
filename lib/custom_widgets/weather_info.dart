import 'package:flora/models/weather_data.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
 final double temperatureFontSize = 25.sp;
  final double conditionFontSize = 20.sp;
  final double infoFontSize = 18.sp;
  const double spacing = 12.0;
  const Color textColor = Colors.black;
  const String fontFamily = 'Dosis';
  const String apiKey ='4c76edb6dd3449f8c69aa0e350a0c32e';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({super.key});

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  final String apiKey = '4c76edb6dd3449f8c69aa0e350a0c32e'; // Replace with your OpenWeatherMap API key

  WeatherData? weatherData;
  String locationName = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      Position position = await _determinePosition();

      const String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
      final Uri uri = Uri.parse(apiUrl).replace(queryParameters: {
        'lat': position.latitude.toString(),
        'lon': position.longitude.toString(),
        'appid': apiKey,
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        WeatherData fetchedWeatherData = WeatherData.fromJson(data);
        setState(() {
          weatherData = fetchedWeatherData;
        });
      } else {
        throw 'Failed to fetch weather data. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        locationName = 'Error: $e';
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = (await Geolocator.requestPermission()) as bool;
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied.';
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
          top: screenHeight * 0.05,
          bottom: screenHeight * 0.05),
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(screenWidth * 0.05),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherData?.temperature ?? '26 C',
                          style: TextStyle(
                            fontSize: temperatureFontSize * textScaleFactor,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: spacing * textScaleFactor),
                        Text(
                          weatherData?.condition ?? 'Partly Cloudy',
                          style: TextStyle(
                            fontSize: conditionFontSize * textScaleFactor,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Humidity',
                          style: TextStyle(
                            fontSize: infoFontSize * textScaleFactor,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            color: AppColors.accentColor,
                          ),
                        ),
                        SizedBox(height: spacing * textScaleFactor),
                        Text(
                          'Wind Speed',
                          style: TextStyle(
                            fontSize: infoFontSize * textScaleFactor,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            color: AppColors.accentColor,
                          ),
                        ),
                        SizedBox(height: spacing * textScaleFactor),
                        Text(
                          'Visibility',
                          style: TextStyle(
                             fontWeight: FontWeight.w400,
                            fontSize: infoFontSize * textScaleFactor,
                            fontFamily: fontFamily,
                            color: AppColors.accentColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherData?.humidity ?? '60%',
                          style: TextStyle(
                            fontSize: infoFontSize * textScaleFactor,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: spacing * textScaleFactor),
                        Text(
                          weatherData?.windSpeed ?? '20m/h',
                          style: TextStyle(
                            fontSize: infoFontSize * textScaleFactor,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: spacing * textScaleFactor),
                        Text(
                          weatherData?.visibility ?? 'Low',
                          style: TextStyle(
                            fontSize: infoFontSize * textScaleFactor,
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamily,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
