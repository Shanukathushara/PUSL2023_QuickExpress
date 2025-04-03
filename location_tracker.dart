import 'package:flutter/material.dart';

class LocationTrackerPage extends StatelessWidget {
  const LocationTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4B5EFC),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Live Location Tracker',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B5EFC),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Input Field for Booking ID or Bus Number
                  _buildBookingInput(),
                  SizedBox(height: 20),
                  // Location Status Card with additional details
                  _buildLocationCard(),
                  SizedBox(height: 20),
                  // Action Buttons for interactions
                  _buildActionButtons(),
                  SizedBox(height: 20),
                  // Placeholder for Map or Tracking View
                  _buildLocationMap(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Input Field for Booking ID or Bus Number
  Widget _buildBookingInput() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Enter Booking ID or Bus Number',
        hintText: 'e.g., 978354125 or Bus #125',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      ),
    );
  }

  // Detailed Location Card with bus number, current location, and booking details
  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4B5EFC), // Blue shadow
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(4, 0), // Shadow direction
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          Text('Bus #125 - Colombo ➝ Airport Terminal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('Booking ID: 978354125',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700)),
          SizedBox(height: 12),
          Text('Seat: 12B - Booked by: Namal',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700)),
          SizedBox(height: 12),
          Text('Latitude: 40.7128 N, Longitude: 74.0060 W',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700)),
          SizedBox(height: 12),
          Text('Estimated Arrival: 12:30 PM',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  // Action Buttons to interact with the app
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4B5EFC),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // Action for tracking the bus
          },
          icon: Icon(Icons.track_changes, color: Colors.white),
          label: Text('Track Bus', style: TextStyle(color: Colors.white)),
        ),
        SizedBox(width: 16),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[500],
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // Action for notifications
          },
          icon: Icon(Icons.notifications, color: Colors.white),
          label: Text('Alerts', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  // Map Display with User Location and Route Tracking
  Widget _buildLocationMap() {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: [
          // Interactive Map Placeholder (can be replaced with an actual map widget)
          Center(
            child: Icon(
              Icons.location_on,
              size: 60,
              color: Color(0xFF4B5EFC),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              'Current Route: Central Station ➝ Airport Terminal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B5EFC),
              ),
            ),
          ),
          // Animated Bus Marker Placeholder (You can replace with actual animation logic)
          Positioned(
            top: 50,
            right: 20,
            child: Icon(
              Icons.directions_bus,
              color: Color(0xFF4B5EFC),
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
