import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import firebase storage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

final firestore = FirebaseFirestore.instance;

Future<String> generateImage(imageUrl) async {
  // Initialize Firebase
  print("image url called");
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
  var documentRef = firestore.collection('images').doc();
  await documentRef.set({
    'url': imageUrl,
    // add the text prompt along with the image
    'prompt': "test",
    'storagePath': storageRef.fullPath,
    'createdAt': FieldValue.serverTimestamp(),
  });

  return imageUrl;
}

class NewPage extends StatelessWidget {
  final String imageUrl;

  NewPage({required Key key, required this.imageUrl}) : super(key: key);

  //inot state print the image url
  void initState() {
    print("image url is $imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                // fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text('Go back!'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/second');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text(
                'Publish ',
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.black,
              onPressed: () async {
                //save the imageUrl to realtime database
                await generateImage(imageUrl);
                //when the image is saved to the database, show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image Saved in database'),
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
