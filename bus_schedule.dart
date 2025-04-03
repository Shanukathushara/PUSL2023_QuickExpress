import 'package:flutter/material.dart';

class BusSchedulePage extends StatelessWidget {
  BusSchedulePage({super.key});

  final List<Map<String, String>> busSchedules = [
    {
      'busName': 'Bus 101',
      'departure': '8:00 AM',
      'arrival': '9:00 AM',
      'departureLocation': 'Central Station',
      'arrivalLocation': 'North Terminal',
      'status': 'On Time',
      'distance': '45 km',
      'busType': 'Express',
      'platform': 'Platform 3',
    },
    {
      'busName': 'Bus 102',
      'departure': '9:30 AM',
      'arrival': '10:30 AM',
      'departureLocation': 'South Station',
      'arrivalLocation': 'East Terminal',
      'status': 'Delayed',
      'distance': '38 km',
      'busType': 'Regular',
      'platform': 'Platform 1',
    },
    {
      'busName': 'Bus 103',
      'departure': '11:00 AM',
      'arrival': '12:00 PM',
      'departureLocation': 'West Station',
      'arrivalLocation': 'Central Terminal',
      'status': 'On Time',
      'distance': '52 km',
      'busType': 'Express',
      'platform': 'Platform 2',
    },
    {
      'busName': 'Bus 104',
      'departure': '1:30 PM',
      'arrival': '2:30 PM',
      'departureLocation': 'North Station',
      'arrivalLocation': 'South Terminal',
      'status': 'Boarding',
      'distance': '40 km',
      'busType': 'Regular',
      'platform': 'Platform 4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4B5EFC), // Custom color for the AppBar
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
        title: Text(
          'Bus Schedules',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming Bus Schedules',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B5EFC),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: busSchedules.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      title: Text(
                        busSchedules[index]['busName']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B5EFC),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                busSchedules[index]['departureLocation']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Icon(Icons.arrow_right_alt,
                                  size: 16, color: Colors.grey),
                              Text(
                                busSchedules[index]['arrivalLocation']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                '${busSchedules[index]['departure']} - ${busSchedules[index]['arrival']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color:
                              _getStatusColor(busSchedules[index]['status']!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          busSchedules[index]['status']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Divider(),
                              _buildDetailRow(Icons.directions_bus, 'Bus Type',
                                  busSchedules[index]['busType']!),
                              _buildDetailRow(Icons.social_distance, 'Distance',
                                  busSchedules[index]['distance']!),
                              _buildDetailRow(Icons.confirmation_number,
                                  'Platform', busSchedules[index]['platform']!),
                              SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF4B5EFC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Book Ticket',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4B5EFC),
        onPressed: () {},
        child: Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Color(0xFF4B5EFC)),
          SizedBox(width: 10),
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'on time':
        return Colors.green;
      case 'delayed':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'boarding':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
