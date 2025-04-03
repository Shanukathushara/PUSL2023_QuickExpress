import 'package:flutter/material.dart';

class TicketPricesPage extends StatelessWidget {
  TicketPricesPage({super.key});

  // Sample ticket price and bus details data with LKR currency
  final List<Map<String, String>> ticketPrices = [
    {
      'route': 'Route A',
      'adult': '1,600 LKR',
      'child': '800 LKR',
      'student': '950 LKR',
      'departure': '6:00 AM',
      'arrival': '8:00 AM',
      'busType': 'Standard Bus',
      'departureLocation': 'Central Station',
      'arrivalLocation': 'North Terminal',
      'distance': '25 km',
      'amenities': 'Wi-Fi, USB Charging',
      'stops': '3 stops',
      'availability': 'High',
    },
    {
      'route': 'Route B',
      'adult': '1,900 LKR',
      'child': '950 LKR',
      'student': '1,100 LKR',
      'departure': '7:00 AM',
      'arrival': '9:00 AM',
      'busType': 'Luxury Bus',
      'departureLocation': 'South Station',
      'arrivalLocation': 'East Terminal',
      'distance': '38 km',
      'amenities': 'Wi-Fi, AC, Reclining Seats',
      'stops': 'Direct',
      'availability': 'Medium',
    },
    {
      'route': 'Route C',
      'adult': '1,400 LKR',
      'child': '650 LKR',
      'student': '950 LKR',
      'departure': '8:00 AM',
      'arrival': '10:00 AM',
      'busType': 'Standard Bus',
      'departureLocation': 'West Station',
      'arrivalLocation': 'Downtown',
      'distance': '22 km',
      'amenities': 'Basic Seating',
      'stops': '5 stops',
      'availability': 'High',
    },
    {
      'route': 'Route D',
      'adult': '2,200 LKR',
      'child': '1,100 LKR',
      'student': '1,250 LKR',
      'departure': '9:00 AM',
      'arrival': '11:00 AM',
      'busType': 'Premium Bus',
      'departureLocation': 'Airport',
      'arrivalLocation': 'City Center',
      'distance': '45 km',
      'amenities': 'Wi-Fi, AC, Entertainment, Snacks',
      'stops': '2 stops',
      'availability': 'Low',
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
          'Ticket Prices & Bus Details',
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
              'Ticket Prices & Bus Schedule',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B5EFC),
              ),
            ),
            SizedBox(height: 20),
            // Filter and sort options
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.filter_list, color: Color(0xFF4B5EFC)),
                  SizedBox(width: 8),
                  Text(
                    'Filter by:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('Standard'),
                          _buildFilterChip('Luxury'),
                          _buildFilterChip('Premium'),
                          _buildFilterChip('Morning'),
                          _buildFilterChip('Direct'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: ticketPrices.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.all(16),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ticketPrices[index]['route']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B5EFC),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: _getBusTypeColor(
                                      ticketPrices[index]['busType']!),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  ticketPrices[index]['busType']!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ticketPrices[index]['departureLocation']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      ticketPrices[index]['departure']!,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Icon(Icons.arrow_forward,
                                      color: Color(0xFF4B5EFC)),
                                  Text(
                                    ticketPrices[index]['distance']!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      ticketPrices[index]['arrivalLocation']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                    Text(
                                      ticketPrices[index]['arrival']!,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildPriceColumn(
                                'Adult', ticketPrices[index]['adult']!),
                            _buildPriceColumn(
                                'Child', ticketPrices[index]['child']!),
                            _buildPriceColumn(
                                'Student', ticketPrices[index]['student']!),
                          ],
                        ),
                      ),
                      children: [
                        Divider(),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow(Icons.info_outline, 'Stops',
                                  ticketPrices[index]['stops']!),
                              _buildDetailRow(
                                  Icons.airline_seat_recline_normal,
                                  'Amenities',
                                  ticketPrices[index]['amenities']!),
                              _buildDetailRow(Icons.event_seat, 'Availability',
                                  ticketPrices[index]['availability']!),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.info_outline, size: 16),
                                    label: Text('Details'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Color(0xFF4B5EFC),
                                      side:
                                          BorderSide(color: Color(0xFF4B5EFC)),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.confirmation_number,
                                        size: 16),
                                    label: Text('Book Now'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF4B5EFC),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
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
    );
  }

  Widget _buildPriceColumn(String label, String price) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF4B5EFC),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Color(0xFF4B5EFC), width: 1),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Color(0xFF4B5EFC)),
          SizedBox(width: 8),
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Color _getBusTypeColor(String busType) {
    switch (busType.toLowerCase()) {
      case 'standard bus':
        return Colors.blue;
      case 'luxury bus':
        return Colors.purple;
      case 'premium bus':
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }
}
