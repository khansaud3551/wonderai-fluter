import 'dart:async';
//import http package
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wonderai/ImageResult.dart';
import 'package:wonderai/splashscreen.dart';
import "package:flutter/src/rendering/box.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
//import second screen
import 'package:wonderai/second_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.white,
      ),
      //make routes
      // home: Splash2(),
      routes: {
        '/': (context) => Splash2(),
        '/second': (context) => SecondScreen(inputData: ""),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}
