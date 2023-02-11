import 'dart:async';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
//import main.dart
import 'package:wonderai/main.dart';

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new SecondScreen(),
      // title: new Text(
      //   'GeeksForGeeks',
      //   textScaleFactor: 2,
      // ),

      image: Image.asset('assets/logo.png'),
      // loadingText: Text("Loading"),
      photoSize: 100.0,
      // loaderColor: Colors.blue,
    );
  }
}
