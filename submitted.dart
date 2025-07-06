import 'package:bloodapp/main.dart';
import 'package:flutter/material.dart';
import 'main.dart'; // Make sure this is your actual home page file

class SubmittedDataPage extends StatelessWidget {
  final Map<String, String> data;

  const SubmittedDataPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Image
            Image.asset(
              'assets/10.jpg',
              width: 430,
              height: 700,
              fit: BoxFit.fill,
            ),

            // Foreground Data Card
            Container(
              width: 320,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    'Submitted Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),

                  // Profile Icon
                 // Profile Icon with Red Border
Container(
  padding: EdgeInsets.all(4), // Space for the border
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.red, width: 3), // Border color and width
  ),
  child: CircleAvatar(
    radius: 35,
    backgroundColor: Colors.black,
    child: Icon(Icons.person, size: 35, color: Colors.white),
  ),
),


                  // Submitted Data
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${entry.key}: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                entry.value,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 25),

                  // Back to Home Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BloodApp()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.arrow_back, size: 30, color: Colors.black),
                        SizedBox(height: 5),
                        Text(
                          'Back to home',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
