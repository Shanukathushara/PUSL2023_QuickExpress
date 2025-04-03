import 'package:flutter/material.dart';

class LiveBusAlertsPage extends StatefulWidget {
  const LiveBusAlertsPage({super.key});

  @override
  State<LiveBusAlertsPage> createState() => _LiveBusAlertsPageState();
}

class _LiveBusAlertsPageState extends State<LiveBusAlertsPage> {
  bool _showBookings = true;

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
              scale: 3.5, // Increase the scale factor to zoom in
              child: SizedBox(
                height: 120, // Set a smaller fixed size
                width: 50,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  color: Colors.white, // Ensures it covers the container
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
              'Live Bus Alerts',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B5EFC),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showBookings = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                        color: _showBookings
                            ? Color(0xFF4B5EFC)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'MY BOOKINGS',
                          style: TextStyle(
                            color: _showBookings ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showBookings = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      decoration: BoxDecoration(
                        color: !_showBookings
                            ? Color(0xFF4B5EFC)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'SCHEDULES',
                          style: TextStyle(
                            color: !_showBookings ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _showBookings
                ? _buildBookingsSection()
                : _buildSchedulesSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsSection() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildBookingAlertCard('003', '23', 'NB-1234', '20min ago'),
        SizedBox(height: 16),
        _buildBookingAlertCard('002', '27', 'NB-1234', '2 Days ago'),
        SizedBox(height: 16),
        _buildBookingAlertCard('001', '21', 'NB-1234', '5 Days ago'),
      ],
    );
  }

  Widget _buildSchedulesSection() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _buildScheduleCard('R-101', 'Central Station', 'Airport Terminal',
            '07:30 AM', '08:15 AM', 'On Time', Colors.green),
        SizedBox(height: 16),
        _buildScheduleCard('R-205', 'North Bus Terminal', 'South Mall',
            '09:45 AM', '10:30 AM', 'Delayed', Colors.orange),
        SizedBox(height: 16),
        _buildScheduleCard('R-310', 'West Station', 'East Harbor', '11:15 AM',
            '12:00 PM', 'Cancelled', Colors.red),
      ],
    );
  }

  Widget _buildBookingAlertCard(String bookingNumber, String seatNumber,
      String busNumber, String timeAgo) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4B5EFC), // Add a subtle blue shade
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(4, 0), // Shift the shadow to the right
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BOOKING #$bookingNumber',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          Text('Seat No: $seatNumber of bus $busNumber successfully booked',
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Thank you!', style: TextStyle(fontSize: 16)),
              Text(timeAgo,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(
      String routeNumber,
      String origin,
      String destination,
      String departureTime,
      String arrivalTime,
      String status,
      Color statusColor) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4B5EFC), // Add a subtle blue shade
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(4, 0), // Shift the shadow to the right
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ROUTE #$routeNumber',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          Text('$origin ➝ $destination', style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
          Text('Departure: $departureTime   Arrival: $arrivalTime',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
