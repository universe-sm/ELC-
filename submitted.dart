import 'package:bloodapp/main.dart';
import 'main.dart'; // Make sure this is your actual home page file
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubmittedDataPage extends StatefulWidget {
  @override
  _SubmittedDataPageState createState() => _SubmittedDataPageState();
}

class _SubmittedDataPageState extends State<SubmittedDataPage> {
  List<dynamic> submittedData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubmittedData();
  }

  Future<void> fetchSubmittedData() async {
    final url = Uri.parse('http://192.168.104.45/backend/get_data.php'); // Replace with your actual IP and backend folder path

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          submittedData = data;
          isLoading = false;
        });
      } else {
        print("Failed to fetch data");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/10.jpg',
              width: 430,
              height: 700,
              fit: BoxFit.fill,
            ),
            Container(
              width: 320,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : submittedData.isEmpty
                      ? Center(child: Text("No submissions found!"))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: submittedData.length,
                          itemBuilder: (context, index) {
                            final item = submittedData[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${item['name']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Email: ${item['email']}',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  'Age: ${item['age']}',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Divider(color: Colors.black),
                              ],
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
