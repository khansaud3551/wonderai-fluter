//import http package
import 'package:flutter/material.dart';
import 'package:wonderai/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
//import second screen
import 'package:wonderai/second_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(fontFamily: "Poppins"),
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
