import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

// Import your new LiveBusAlertsPage
import 'live_bus_alerts_page.dart';
import 'book_seat.dart';
import 'bus_schedule.dart';
import 'location_tracker.dart';
import 'lost_found.dart';
import 'reviews_complaints.dart';
import 'ticket_prices.dart';
import 'news_feed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(BusTrackingApp());
}

class Firebase {
  static initializeApp() {}
}

Future<List<dynamic>> fetchBusAlerts() async {
  // ignore: prefer_typing_uninitialized_variables
  var http;
  final response = await http.get(Uri.parse("http://your-server-ip:5000/alerts"));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to load bus alerts");
  }
}
void addBusAlert(String alertMessage) {
  FirebaseFirestore.instance.collection('bus_alerts').add({
    'message': alertMessage,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

class FieldValue {
  static serverTimestamp() {}
}

class FirebaseFirestore {
  // ignore: prefer_typing_uninitialized_variables
  static var instance;
}
class BusTrackingApp extends StatelessWidget {
  const BusTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _timeString = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    setState(() {
      _timeString = formattedTime;
    });
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
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              // ignore: deprecated_member_use
              color: Color(0xFF4B5EFC).withOpacity(0.1),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF4B5EFC).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _timeString,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Digital',
                            color: Colors.white,
                            shadows: [
                              Shadow(blurRadius: 10, color: Colors.black38)
                            ],
                          ),
                        ),
                        Text(
                          DateFormat('EEE, dd MMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            shadows: [
                              Shadow(blurRadius: 10, color: Colors.black38)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        buildButton(
                            'Main News Feed', Icons.article, NewsFeedPage()),
                        buildButton('Live Bus Alerts', Icons.directions_bus,
                            LiveBusAlertsPage()),
                        buildButton('Location Tracker', Icons.gps_fixed,
                            LocationTrackerPage()),
                        buildButton('Bus Schedule', Icons.calendar_today,
                            BusSchedulePage()),
                        buildButton('Ticket Prices', Icons.attach_money,
                            TicketPricesPage()),
                        buildButton('Book Your Seat', Icons.event_seat,
                            BookYourSeatPage()),
                        buildButton('Lost & Found Items', Icons.work_outline,
                            LostAndFoundPage()),
                        buildButton('Reviews & Complaints', Icons.feedback,
                            ReviewsAndComplaintsPage()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String title, IconData icon, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF4B5EFC),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
