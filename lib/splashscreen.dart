import 'dart:async';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
//import second screen
import "package:wonderai/second_screen.dart";

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new SecondScreen(
        inputData: "",
      ),

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
