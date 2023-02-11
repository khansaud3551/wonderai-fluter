import 'dart:async';
//import http package
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wonderai/ImageResult.dart';
import 'package:wonderai/splashscreen.dart';
import "package:flutter/src/rendering/box.dart";
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

Future<String> generateImage() async {
  //test the funtion call by pint text in console

  var data = {
    "prompt": "A photo of a lizzard on a rock",
    "n": 1,
    "size": "256x256",
  };

  print("generateImage() called");
  String url = "https://api.openai.com/v1/images/generations";
  Uri uri = Uri.parse(url);
  final res = await http.post(uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer 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"
      },
      body: jsonEncode(data));

  if (res.statusCode == 200) {
    var jsonResponse = jsonDecode(res.body);
    print(jsonResponse);
    return jsonResponse['data'][0]['url'];
  } else {
    throw Exception("Failed to generate image");
  }
}

// Future<String> generateImage() async {
//     String apikey = 'tsk-nTRcf1113XPQht7r22T3Bvadapavlb5kFJYz1yz5b4xifuyzpoiyom2ooNIQehy';
//   String url = 'https://api.openai.com/v1/images/generations';
//     var data ={
//         "prompt": "A photo of a dog",
//         "n": 1,
//         "size": "256x256",
//       };

//       var res = await http.post(Uri.parse(url),
//           headers: {"Authorization":"Bearer ${apikey}","Content-Type": "application/json"},
//           body:jsonEncode(data));
//       var jsonResponse = jsonDecode(res.body);
//       image = jsonResponse['data'][0]['url'];
//       setState(() {
//       });

//     }else{
//       print("Enter something");
//     }
// }

void main() {
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
      home: Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        //box shadow
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70.0,
              height: 60.0,
              child: Image.asset("assets/logo2.png"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 7.0),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Text(
                "Pro",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        // Logo
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.person),
            onPressed: () {}, // Add your desired behavior for the user icon
          ),
        ],
      ),
      body: // create a row with two text widgets
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add Your Photo +"),
                          Text("I need help inspiration"),
                        ]),

                    SizedBox(height: 10),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserPrompt(),
                        ]),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Row(children: [
                        Text("Aspect Ratio : "),
                        AspectRatio(),
                      ]),
                    ),

                    SizedBox(height: 10),

                    Container(
                      child: Row(children: [
                        ImageSlider(),
                      ]),
                    ),
                    SizedBox(height: 10),
                    // Full width button
                    Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: OutlinedButton.icon(
                          onPressed: () async {
                            String image = await generateImage();
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        NewPage(image: image, key: Key(image)),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = Offset(1.0, 0.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          //styles for the button
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            backgroundColor: Colors.black,
                            side: BorderSide(color: Colors.black, width: 0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('Create')),
                    ),

                    SizedBox(height: 10),

                    Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Prompt Inspirations",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Feed"),
                              ],
                            )
                          ],
                        )),
                  ])),
    );
  }
}

class UserPrompt extends StatefulWidget {
  @override
  _UserPromptState createState() => _UserPromptState();
}

class _UserPromptState extends State<UserPrompt> {
  TextEditingController _textEditingController = TextEditingController();
  String inputText = "";

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 100,
          maxHeight: 100,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            TextField(
              controller: _textEditingController,
              maxLines: 2,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Line 1\nLine 2",
                hintMaxLines: 2,
              ),
              onChanged: (value) {
                setState(() {
                  inputText = value;
                  print(inputText);
                });
              },
            ),
            Positioned(
              right: 7,
              bottom: 7,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.grey[600],
                    size: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//testing
class AspectRatio extends StatefulWidget {
  AspectRatio({Key? key}) : super(key: key);
  @override
  State<AspectRatio> createState() => _AspectRatioState();
}

/// This is the private State class that goes with AspectRatio.
class _AspectRatioState extends State<AspectRatio> {
  int value = 1;
  Widget CustomRadioButton(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.green : Colors.black,
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          color: (value == index) ? Colors.green : Colors.black,
        ),
        minimumSize: Size(70, 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CustomRadioButton("1", 1),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CustomRadioButton("12", 2),
          ),
          Container(
            child: CustomRadioButton("123", 3),
          ),
        ],
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.33,
        initialPage: 0,

        // enableInfiniteScroll: true,
        reverse: false,
        // autoPlay: true,
        // autoPlayInterval: Duration(seconds: 3),
        // autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
      items: imgList
          .map((item) => Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                  ),
                ),
              ))
          .toList(),
    ));
  }
}













// class ImageSlider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       child: CarouselSlider(
//         options: CarouselOptions(
//           height: 200.0,
//           aspectRatio: 16 / 9,
//           viewportFraction: 1.0,
//           initialPage: 0,
//           enableInfiniteScroll: true,
//           reverse: false,
//           autoPlay: true,
//           autoPlayInterval: Duration(seconds: 3),
//           autoPlayAnimationDuration: Duration(milliseconds: 800),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           enlargeCenterPage: false,
//           scrollDirection: Axis.horizontal,
//         ),
//         items: [
//           Container(
//             height: 200,
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 "https://picsum.photos/id/1018/1000/600",
//                 fit: BoxFit.cover,
//                 height: 100,
//               ),
//             ),
//           ),
//           Container(
//             height: 200,
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 "https://picsum.photos/id/1015/1000/600",
//                 fit: BoxFit.cover,
//                 height: 100,
//               ),
//             ),
//           ),
//           Container(
//             height: 200,
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 "https://picsum.photos/id/1019/1000/600",
//                 fit: BoxFit.cover,
//                 height: 100,
//               ),
//             ),
//           ),
//           Container(
//             height: 200,
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 "https://picsum.photos/id/1020/1000/600",
//                 fit: BoxFit.cover,
//                 height: 100,
//               ),
//             ),
//           ),
//           Container(
//             height: 200,
//             margin: EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//               child: Image.network(
//                 "https://picsum.photos/id/1021/1000/600",
//                 fit: BoxFit.cover,
//                 height: 100,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
