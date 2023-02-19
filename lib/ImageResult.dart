import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import firebase storage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

final firestore = FirebaseFirestore.instance;

Future<String> generateImage(imageUrl) async {
  // Initialize Firebase
  print("image url called $imageUrl");
  await Firebase.initializeApp();
  // Check if there is a current user
  // var user = FirebaseAuth.instance.currentUser;
  // if (user == null) {
  //   //sihn in
  //   await FirebaseAuth.instance.signInAnonymously();
  // }

  // Generate OpenAI image

  //download the image from the URL
  var imageBytes = await http.get(Uri.parse(imageUrl));
  //save the image to firebase storage
  var storage = FirebaseStorage.instance;
  var uniqueIdentifier = DateTime.now().millisecondsSinceEpoch.toString();
  var storageRef = storage
      .ref()
      .child('images')
      .child('generated_image_$uniqueIdentifier.png');
  await storageRef.putData(
      imageBytes.bodyBytes, SettableMetadata(contentType: 'image/png'));
  //save the image URL to firestore
  // var documentRef = firestore.collection('images').doc();
  // await documentRef.set({
  //   'url': imageUrl,
  //   // add the text prompt along with the image
  //   'prompt': "test",
  //   'storagePath': storageRef.fullPath,
  //   'createdAt': FieldValue.serverTimestamp(),
  // });

  return imageUrl;
}

class NewPage extends StatelessWidget {
  final String imageUrl;
  // final bool isLoading;
  final List images;

  NewPage({required Key key, required this.imageUrl, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.fill)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Go back!'),
                    ),
                  ),
                  SizedBox(width: 16), // add space between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await generateImage(imageUrl);
                        //update the UI
                        // setState(() {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Image saved in database'),
                          ),
                        );
                      },
                      child: Text('Save Image'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Center(
          //     child: isLoading
          //         ? const CircularProgressIndicator(
          //             color: Colors.black,
          //           )
          //         : Text(isLoading ? "Loading" : "not loading"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
