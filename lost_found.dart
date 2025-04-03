// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LostAndFoundPage(),
  ));
}

class LostAndFoundPage extends StatefulWidget {
  const LostAndFoundPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LostAndFoundPageState createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends State<LostAndFoundPage> {
  File? _image;
  final picker = ImagePicker();
  String _selectedRoute = "Route A";
  final List<String> routes = ["Route A", "Route B", "Route C", "Other"];
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
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
            Text("Report Lost Item",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: "Item Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              value: _selectedRoute,
              items: routes.map((route) {
                return DropdownMenuItem(
                  value: route,
                  child: Text(route),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRoute = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: "Select Route",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text("Select Time Lost: ${_selectedTime.format(context)}"),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 175, 177, 193),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Submit Lost Item Report"),
            ),
          ],
        ),
      ),
    );
  }
}
