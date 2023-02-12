import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  final String image;

  NewPage({required Key key, required this.image}) : super(key: key);

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
                image,
                // fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('Go back!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
