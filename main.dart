import 'package:flutter/material.dart';
import 'processing_page.dart';

void main() => runApp(BloodApp());

class BloodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Centered image
            Image.asset(
              'assets/hand.png',
              width: 430,
              height:700,
              fit: BoxFit.fill,
            ),

            // Play button inside the image, positioned to the right
            Positioned(
              right:65,
              child: IconButton(
                icon: Icon(
                  Icons.play_circle_fill,
                  color: Colors.red,
                  size: 64,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProcessingPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
