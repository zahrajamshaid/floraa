import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flora/change_notifiers/user_provider.dart';
import 'package:flora/firebase_options.dart';

import 'package:flora/screens/dashboard.dart';
import 'package:flora/screens/login.dart';

import 'package:flora/screens/onboard1.dart';
import 'package:flora/screens/onboard2.dart';
import 'package:flora/screens/onboard3.dart';
import 'package:flora/screens/profile.dart';
import 'package:flora/screens/scanner.dart';
import 'package:flora/screens/signup.dart';
import 'package:flora/screens/splash.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: FloraApp(),
    ),
  );
}


class FloraApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flora',
      home:SplashScreen(),
    );
  }
}
