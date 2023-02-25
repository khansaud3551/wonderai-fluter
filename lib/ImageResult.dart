import 'dart:convert';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import firebase storage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

final firestore = FirebaseFirestore.instance;

Future<String> generateImage(String imageUrl, String prompt) async {
  // Initialize Firebase
  print("image url called $imageUrl");
  await Firebase.initializeApp();

  //download the image from the URL
  var imageBytes = await http.get(Uri.parse(imageUrl));

  // Encode the prompt as a JSON string
  var data = {
    'prompt': prompt,
  };
  var promptJson = jsonEncode(data);

  //save the image and prompt to firebase storage
  var storage = FirebaseStorage.instance;
  var uniqueIdentifier = DateTime.now().millisecondsSinceEpoch.toString();
  var storageRef = storage
      .ref()
      .child('images')
      .child('generated_image_$uniqueIdentifier.png');
  // put the text prompt in the metadata
  await storageRef.putData(
      imageBytes.bodyBytes,
      SettableMetadata(contentType: 'image/png', customMetadata: {
        'prompt': prompt,
      }));
  // await storageRef.putData(
  //     imageBytes.bodyBytes, SettableMetadata(contentType: 'image/png'));

  return imageUrl;
}

class NewPage extends StatefulWidget {
  final String imageUrl;
  final String inputData;
  final List images;
  //funciton updateImagesList
  final Function updateImagesList;

  NewPage(
      {required Key key,
      required this.imageUrl,
      required this.inputData,
      required this.images,
      required this.updateImagesList})
      : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  bool isLoading = false;
  // String imageUrl = ;
  List images = [];

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
                      image: NetworkImage(
                        widget.imageUrl,
                      ),
                      fit: BoxFit.fill)),
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
                        //go back t homepage with updated list
                        setState(() {
                          images.add(widget.imageUrl);
                        });

                        // widget.updateImagesList();
                        Navigator.pop(context, images);
                      },
                      child: const Text('Go back!'),
                    ),
                  ),
                  SizedBox(width: 16), // add space between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await generateImage(widget.imageUrl, widget.inputData);
                        widget.updateImagesList();
                        //update the UI
                        setState(() {
                          images.add(widget.imageUrl);
                        });

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
