import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'dart:io';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReviewsAndComplaintsPage(),
  ));
}

class ReviewsAndComplaintsPage extends StatefulWidget {
  const ReviewsAndComplaintsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReviewsAndComplaintsPageState createState() =>
      _ReviewsAndComplaintsPageState();
}

class _ReviewsAndComplaintsPageState extends State<ReviewsAndComplaintsPage> {
  File? _image;
  final picker = ImagePicker();
  String _selectedCategory = "Service Issue";
  final List<String> categories = [
    "Service Issue",
    "Product Issue",
    "Billing Issue",
    "Other"
  ];

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4B5EFC),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Transform.scale(
              scale: 3.5,
              child: SizedBox(
                height: 120,
                width: 50,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Submit a Complaint",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: _selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: "Select Complaint Category",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Describe Your Issue",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: getImage,
              child: Text("Attach Photo"),
            ),
            if (_image != null) ...[
              SizedBox(height: 10),
              Image.file(_image!, height: 150, fit: BoxFit.cover),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              // ignore: sort_child_properties_last
              child: Text("Submit Complaint"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 165, 167, 182),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on ImagePicker {
  pickImage({required source}) {}
}

class ImageSource {
  // ignore: prefer_typing_uninitialized_variables
  static var gallery;
}

class ImagePicker {}
