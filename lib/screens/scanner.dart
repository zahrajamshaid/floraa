
import 'package:flora/custom_widgets/custom_button.dart';
import 'package:flora/models/plant.dart';
import 'package:flora/screens/dashboard.dart';
import 'package:flora/theme.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  List<Plant> identifiedPlants = [];
  String errorMessage = '';

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> identifyPlant() async {
    if (_pickedImage == null) {
      setState(() {
        errorMessage = 'Please select an image first.';
      });
      return;
    }

    List<Plant> plants = [];
    final List<int> imageBytes = await _pickedImage!.readAsBytes();
    final base64Image = base64Encode(imageBytes);
    const String endpoint = 'https://api.plant.id/v2/identify';

    try {
      http.Response response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Api-Key': 'kCrgQK0TktwSkAdYKe1BI0uDcRPc9abw1b30xhbVCR5l0zhol2',
        },
        body: jsonEncode({
          'images': [base64Image],
          'modifiers': ['similar_images'],
          'plant_details': [
            'common_names',
            'url',
            'description',
            'taxonomy',
            'rank',
            'gbif_id',
            'inaturalist_id',
            'image',
            'images',
            'synonyms',
            'edible_parts',
            'propagation_methods',
            'watering',
          ],
        }),
      );

      Map<String, dynamic> results =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (results.containsKey('suggestions')) {
        List<dynamic> suggestions = results['suggestions'];

        for (var suggestion in suggestions) {
          Map<String, dynamic> plant = suggestion as Map<String, dynamic>;
          String name = plant['plant_name'] as String;
    
          plants.add(Plant(
            id: plant['id'] as int,
            probability: (plant['probability'] as double) * 100,
            plantName: name,
            plantDetails: plant['plant_details'],
          ));
        }

        setState(() {
          identifiedPlants = plants;
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'No plant found.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }

  Future<String> getHTMLDoc(String query) async {
    String result = '';
    String url = 'https://www.google.com/search?q=$query&source=lnms&tbm=isch';
    Map<String, String> headers = {
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
      'User-Agent':
          "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36"
    };

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      result = response.body;
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<String> getImageFromWeb(String query) async {
    String result = '';
    String html = await getHTMLDoc(query);
    BeautifulSoup bs = BeautifulSoup(html);
    String raw = bs.find('img', class_: 'yWs4tf').toString();
    result = raw.split('src="').last.split(';').first;

    return result;
  }

  // Function to show the plant details in a dialog
  void showPlantDetailsDialog(Plant plant) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Plant Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Plant Name: ${plant.plantName}'),
                Text('Plant Probability: ${plant.probability}%'),
                const Text('Plant Details:'),
                ...buildPlantDetailsWidgets(plant),
              ],
            ),
          ),
          actions: [
            CustomButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            buttonText: 'Close',
            ),
          ],
        );
      },
    );
  }

  // Function to build the plant details widgets
List<Widget> buildPlantDetailsWidgets(Plant plant) {


  return [
    Container(
      
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: AppColors.backgroundColor, 
      ),
// Set the background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: plant.plantDetails!.entries.map((detail) {
          if (detail.key == 'url') {
            return ListTile(
              title: Text(
                detail.key,
                style: const TextStyle(
                  color: Colors.white, // Set the key text color to white
                  fontFamily: 'Dosis', // Set the font to 'Dosis'
                ),
              ),
              subtitle: InkWell(
                onTap: () {
                  _launchURL(detail.value.toString());
                },
                child: Text(
                  detail.value.toString(),
                  style: const TextStyle(
                    color: Colors.yellow, // Set the other text color to yellow
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            );
          } else if (detail.key == 'image' && detail.value is String) {
            return ListTile(
              title: Text(
                detail.key,
                style: const TextStyle(
                  color: Colors.white, // Set the key text color to white
                  fontFamily: 'Dosis', // Set the font to 'Dosis'
                ),
              ),
              subtitle: Image.network(detail.value as String),
            );
          } else {
            return ListTile(
              title: Text(
                detail.key,
                style: const TextStyle(
                  color: Colors.white, // Set the key text color to white
                  fontFamily: 'Dosis', // Set the font to 'Dosis'
                ),
              ),
              subtitle: Text(
                detail.value.toString(),
                style: const TextStyle(
                  color: Colors.yellow, // Set the other text color to yellow
                ),
              ),
            );
          }
        }).toList(),
      ),
    ),
  ];
}


 

  // Function to launch a URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to open the image picker
  Future<void> _pickImage() async {
    final PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _pickedImage = pickedImage;
        });
      }
    } else {
      // Handle the case where the user denied permission
      print('Permission denied');
    }
  }
Future<void> captureImage() async {
  final PermissionStatus permissionStatus = await Permission.camera.request();
  if (permissionStatus.isGranted) {
    final XFile? capturedImage = await _picker.pickImage(source: ImageSource.camera);
    if (capturedImage != null) {
      // The captured image is stored in `capturedImage`.
      setState(() {
        _pickedImage = capturedImage;
      });
    }
  } else {
    // Handle the case where the user denied camera permission.
    print('Permission denied');
  }
}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
    elevation: 0,
    backgroundColor: AppColors.backgroundColor,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Colors.white,
      onPressed: () {
        // Navigate to the homepage when the back arrow is pressed
        Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
      },
    ),
    title: Center(
      child: Text(
        'Scanning',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          fontFamily: 'Dosis',
        ),
      ),
    ),
  ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
            ),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                        width: double.infinity,
                        height: screenHeight, // Adjust the height
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          image: DecorationImage(
                            image: AssetImage('lib/images/scanner_bg.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Add spacing

                        child: Column(children: [
                          const SizedBox(height: 70),
                          Container(
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.35, // Adjust the height
                            color: Colors.black, // Replace with camera preview
                            child: _pickedImage != null
                                ? Image.file(File(_pickedImage!.path),
                                    fit: BoxFit.cover)
                                : Container(), // Display the picked image here if available, or an empty container
                          ),
                          if (errorMessage.isNotEmpty)
                            Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {

                                    captureImage();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                        0x00000000), // Transparent background
                                  ),
                                  child: const Text('Capture'),
                                ),
                                ElevatedButton(
                                  onPressed: _pickImage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                        0x00000000), // Transparent background
                                  ),
                                  child: const Text('Pick Image'),
                                ),
                                if (_pickedImage != null)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                          0x00000000), // Transparent background
                                    ),
                                    onPressed: () async {
                                      identifyPlant();
                                    },
                                    child: const Text('Identify Plant'),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              width: double.infinity,
                              height: screenHeight * 0.4, // Adjust the height
                              decoration: BoxDecoration(
                                color:
                                    AppColors.backgroundColor.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              child: CustomScrollView(
                                slivers: <Widget>[
                                  SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                      final plant = identifiedPlants[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      120, // Adjust the width as needed
                                                  child: Text(
                                                    'Plant Name',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          255, 255, 255, 0.3),
                                                      fontFamily: 'Dosis',
                                                      fontSize: 18.sp,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 22.0 / 12.0,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      120, // Adjust the width as needed
                                                  child: Text(
                                                    'Plant Probability',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color.fromRGBO(
                                                          255, 255, 255, 0.3),
                                                      fontFamily: 'Dosis',
                                                      fontSize: 18.sp,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 22.0 / 12.0,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width:
                                                    120, // Adjust the width as needed
                                                child: Text(
                                                  ' ${plant.plantName}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: const Color(0xFFFFFFFF),
                                                    fontFamily: 'Dosis',
                                                    fontSize: 17.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    120, // Adjust the width as needed
                                                child: Text(
                                                  '${plant.probability} %',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: const Color(0xFFFFFFFF),
                                                    fontFamily: 'Dosis',
                                                    fontSize: 17.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Center(
                                            child: CustomButton(
                                              onPressed: () {
                                                showPlantDetailsDialog(plant);
                                              },
                                              buttonText: 'View Plant Details',
                                            ),
                                          ),
                                          const Divider(),
                                        ],
                                      );
                                    }, childCount: identifiedPlants.length),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ])))
              ],
            ),
          ),
        ),
      );
    });
  }
}
