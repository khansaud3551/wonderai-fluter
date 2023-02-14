import 'package:flutter/material.dart';
//import firebase storage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

final firestore = FirebaseFirestore.instance;

class NewPage extends StatelessWidget {
  final String imageUrl;

  NewPage({required Key key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                // fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('Go back!'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/second');
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text(
                'Publish ',
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.black,
              onPressed: () async {
                //save the imageUrl to firestore database
                await firestore.collection("images").add({
                  "image_url": imageUrl,
                });
                //when the image is saved to the database, show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Image Saved in database please restart the app to see the image on home page'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
