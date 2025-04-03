import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookYourSeatPage extends StatefulWidget {
  const BookYourSeatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookYourSeatPageState createState() => _BookYourSeatPageState();
}

class _BookYourSeatPageState extends State<BookYourSeatPage> {
  String? startLocation;
  String? destination;
  String? selectedBus;
  String? selectedTime;
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> buses = [];
  List<String> times = [];
  List<bool> seatStatus = List.generate(30, (index) => false);
  double seatPrice = 250.0;
  bool useWallet = false;
  double walletBalance = 50.0;
  int _currentStep = 0; // For three-step process
  bool _isPremiumRoute = false;
  bool _useStoredPayment = false;
  double _discountAmount = 0.0;
  bool _showCalendarIntegration = false;
  int _selectedSeatIndex = -1;
  bool _showBusInterior = false;
  final Map<String, double> _stopCapacityPrediction = {
    'Colombo': 85.0,
    'Kandy': 67.0,
    'Galle': 72.0,
    'Matara': 58.0,
    'Jaffna': 90.0,
  };

  final List<String> locations = [
    'Colombo',
    'Kandy',
    'Galle',
    'Matara',
    'Jaffna'
  ];

  // Updated route-buses mapping to include all possible combinations
  final Map<String, List<String>> routeBuses = {
    'Colombo-Kandy': ['Bus 101', 'Bus 102'],
    'Colombo-Galle': ['Bus 201', 'Bus 202'],
    'Colombo-Matara': ['Bus 203', 'Bus 204'],
    'Colombo-Jaffna': ['Bus 301', 'Bus 302'],
    'Kandy-Colombo': ['Bus 103', 'Bus 104'],
    'Kandy-Galle': ['Bus 205', 'Bus 206'],
    'Kandy-Matara': ['Bus 207', 'Bus 208'],
    'Kandy-Jaffna': ['Bus 303', 'Bus 304'],
    'Galle-Colombo': ['Bus 105', 'Bus 106'],
    'Galle-Kandy': ['Bus 209', 'Bus 210'],
    'Galle-Matara': ['Bus 211', 'Bus 212'],
    'Galle-Jaffna': ['Bus 305', 'Bus 306'],
    'Matara-Colombo': ['Bus 107', 'Bus 108'],
    'Matara-Kandy': ['Bus 213', 'Bus 214'],
    'Matara-Galle': ['Bus 215', 'Bus 216'],
    'Matara-Jaffna': ['Bus 307', 'Bus 308'],
    'Jaffna-Colombo': ['Bus 109', 'Bus 110'],
    'Jaffna-Kandy': ['Bus 217', 'Bus 218'],
    'Jaffna-Galle': ['Bus 219', 'Bus 220'],
    'Jaffna-Matara': ['Bus 309', 'Bus 310'],
  };

  // Updated available times for all buses
  final Map<String, List<String>> availableTimes = {
    'Bus 101': ['08:00 AM', '12:00 PM', '05:00 PM'],
    'Bus 102': ['09:00 AM', '02:00 PM', '06:00 PM'],
    'Bus 103': ['07:30 AM', '01:30 PM', '07:30 PM'],
    'Bus 104': ['10:00 AM', '04:00 PM', '08:00 PM'],
    'Bus 105': ['06:00 AM', '11:00 AM', '03:00 PM'],
    'Bus 106': ['08:30 AM', '01:00 PM', '06:30 PM'],
    'Bus 107': ['07:00 AM', '12:30 PM', '04:30 PM'],
    'Bus 108': ['09:30 AM', '03:30 PM', '07:30 PM'],
    'Bus 109': ['06:30 AM', '11:30 AM', '03:30 PM'],
    'Bus 110': ['08:00 AM', '02:00 PM', '07:00 PM'],
    'Bus 201': ['07:30 AM', '01:30 PM', '07:30 PM'],
    'Bus 202': ['10:00 AM', '04:00 PM', '08:00 PM'],
    'Bus 203': ['06:00 AM', '11:00 AM', '03:00 PM'],
    'Bus 204': ['08:30 AM', '01:00 PM', '06:30 PM'],
    'Bus 205': ['07:00 AM', '12:30 PM', '04:30 PM'],
    'Bus 206': ['09:30 AM', '03:30 PM', '07:30 PM'],
    'Bus 207': ['06:30 AM', '11:30 AM', '03:30 PM'],
    'Bus 208': ['08:00 AM', '02:00 PM', '07:00 PM'],
    'Bus 209': ['07:30 AM', '01:30 PM', '07:30 PM'],
    'Bus 210': ['10:00 AM', '04:00 PM', '08:00 PM'],
    'Bus 211': ['06:00 AM', '11:00 AM', '03:00 PM'],
    'Bus 212': ['08:30 AM', '01:00 PM', '06:30 PM'],
    'Bus 213': ['07:00 AM', '12:30 PM', '04:30 PM'],
    'Bus 214': ['09:30 AM', '03:30 PM', '07:30 PM'],
    'Bus 215': ['06:30 AM', '11:30 AM', '03:30 PM'],
    'Bus 216': ['08:00 AM', '02:00 PM', '07:00 PM'],
    'Bus 217': ['07:30 AM', '01:30 PM', '07:30 PM'],
    'Bus 218': ['10:00 AM', '04:00 PM', '08:00 PM'],
    'Bus 219': ['06:00 AM', '11:00 AM', '03:00 PM'],
    'Bus 220': ['08:30 AM', '01:00 PM', '06:30 PM'],
    'Bus 301': ['07:00 AM', '12:30 PM', '04:30 PM'],
    'Bus 302': ['09:30 AM', '03:30 PM', '07:30 PM'],
    'Bus 303': ['06:30 AM', '11:30 AM', '03:30 PM'],
    'Bus 304': ['08:00 AM', '02:00 PM', '07:00 PM'],
    'Bus 305': ['07:30 AM', '01:30 PM', '07:30 PM'],
    'Bus 306': ['10:00 AM', '04:00 PM', '08:00 PM'],
    'Bus 307': ['06:00 AM', '11:00 AM', '03:00 PM'],
    'Bus 308': ['08:30 AM', '01:00 PM', '06:30 PM'],
    'Bus 309': ['07:00 AM', '12:30 PM', '04:30 PM'],
    'Bus 310': ['09:30 AM', '03:30 PM', '07:30 PM'],
  };

  // Updated route prices in LKR
  final Map<String, double> routePrices = {
    'Colombo-Kandy': 1500.0,
    'Colombo-Galle': 2000.0,
    'Colombo-Matara': 2500.0,
    'Colombo-Jaffna': 3500.0,
    'Kandy-Colombo': 1500.0,
    'Kandy-Galle': 2500.0,
    'Kandy-Matara': 2800.0,
    'Kandy-Jaffna': 3000.0,
    'Galle-Colombo': 2000.0,
    'Galle-Kandy': 2500.0,
    'Galle-Matara': 1000.0,
    'Galle-Jaffna': 3800.0,
    'Matara-Colombo': 2500.0,
    'Matara-Kandy': 2800.0,
    'Matara-Galle': 1000.0,
    'Matara-Jaffna': 4000.0,
    'Jaffna-Colombo': 3500.0,
    'Jaffna-Kandy': 3000.0,
    'Jaffna-Galle': 3800.0,
    'Jaffna-Matara': 4000.0,
  };

  // Window seats
  final List<int> windowSeats = [1, 5, 6, 10, 11, 15, 16, 20, 21, 25, 26, 30];

  // Simulated seat occupancy data
  final Map<String, List<int>> occupiedSeats = {
    'Bus 101': [3, 5, 8, 12, 15, 22, 28],
    'Bus 102': [1, 4, 9, 14, 19, 25],
    'Bus 103': [2, 7, 11, 16, 21, 26],
    'Bus 104': [5, 10, 15, 20, 25, 30],
    'Bus 105': [1, 6, 12, 18, 24, 29],
    'Bus 106': [3, 8, 13, 19, 23, 28],
    'Bus 107': [2, 7, 12, 17, 22, 27],
    'Bus 108': [4, 9, 14, 19, 24, 29],
    'Bus 109': [3, 8, 13, 18, 23, 28],
    'Bus 110': [5, 10, 15, 20, 25, 30],
    'Bus 201': [2, 7, 10, 18, 24, 27],
    'Bus 202': [6, 11, 13, 20, 26, 29],
    'Bus 203': [1, 7, 12, 17, 22, 27],
    'Bus 204': [4, 9, 14, 19, 24, 29],
    'Bus 205': [2, 8, 13, 18, 23, 28],
    'Bus 206': [5, 10, 15, 20, 25, 30],
    'Bus 207': [3, 7, 12, 17, 22, 27],
    'Bus 208': [1, 9, 14, 19, 24, 29],
    'Bus 209': [4, 8, 13, 18, 23, 28],
    'Bus 210': [2, 10, 15, 20, 25, 30],
    'Bus 211': [3, 7, 12, 17, 22, 27],
    'Bus 212': [5, 9, 14, 19, 24, 29],
    'Bus 213': [1, 8, 13, 18, 23, 28],
    'Bus 214': [2, 10, 15, 20, 25, 30],
    'Bus 215': [4, 7, 12, 17, 22, 27],
    'Bus 216': [3, 9, 14, 19, 24, 29],
    'Bus 217': [5, 8, 13, 18, 23, 28],
    'Bus 218': [1, 10, 15, 20, 25, 30],
    'Bus 219': [2, 7, 12, 17, 22, 27],
    'Bus 220': [4, 9, 14, 19, 24, 29],
    'Bus 301': [1, 5, 9, 17, 21, 23],
    'Bus 302': [4, 8, 16, 22, 25, 30],
    'Bus 303': [2, 6, 11, 16, 21, 26],
    'Bus 304': [5, 10, 15, 20, 25, 30],
    'Bus 305': [3, 8, 13, 18, 23, 28],
    'Bus 306': [1, 6, 11, 16, 21, 26],
    'Bus 307': [4, 9, 14, 19, 24, 29],
    'Bus 308': [2, 7, 12, 17, 22, 27],
    'Bus 309': [5, 10, 15, 20, 25, 30],
    'Bus 310': [3, 8, 13, 18, 23, 28],
  };

  // Priority seats
  final List<int> prioritySeats = [1, 2, 3, 4];

  // Premium seats
  final List<int> premiumSeats = [10, 11, 12, 13, 14, 15];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B5EFC),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 50.0),
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
      // Modified to use a Column with Expanded instead of SingleChildScrollView
      body: Column(
        children: [
          // Title and header if needed
          // Modified Stepper to be in an Expanded widget for better scrolling
          Expanded(
            child: Stepper(
              type: StepperType
                  .vertical, // Ensure it's vertical for better scrolling
              currentStep: _currentStep,
              onStepTapped: (int step) {
                setState(() {
                  _currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (_currentStep < 2) {
                    _currentStep += 1;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_currentStep > 0) {
                    _currentStep -= 1;
                  }
                });
              },
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: details.onStepContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B5EFC),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(_currentStep == 2 ? 'Finish' : 'Continue'),
                      ),
                      if (_currentStep > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Back'),
                          ),
                        ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('Select Route & Time'),
                  content: _buildStepOne(),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: const Text('Choose Seat'),
                  content: _buildStepTwo(),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text('Payment'),
                  content: _buildStepThree(),
                  isActive: _currentStep >= 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display selected date and bus information
        if (selectedDate.isNotEmpty || selectedBus != null)
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Selection",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text("Date: $selectedDate"),
                    ],
                  ),
                  if (selectedBus != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          const Icon(Icons.directions_bus, size: 16),
                          const SizedBox(width: 8),
                          Text("Bus: $selectedBus"),
                        ],
                      ),
                    ),
                  if (selectedTime != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, size: 16),
                          const SizedBox(width: 8),
                          Text("Time: $selectedTime"),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: "Starting Location"),
          value: startLocation,
          items: locations.map((location) {
            return DropdownMenuItem<String>(
                value: location, child: Text(location));
          }).toList(),
          onChanged: (value) {
            setState(() {
              if (value != null) {
                startLocation = value;
                buses = [];
                selectedBus = null;
                destination =
                    null; // Reset destination when starting location changes
              }
            });
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: "Destination"),
          value: destination,
          items: locations
              .where((location) =>
                  location != startLocation) // Exclude starting location
              .map((location) {
            return DropdownMenuItem<String>(
                value: location, child: Text(location));
          }).toList(),
          onChanged: (value) {
            setState(() {
              if (value != null && startLocation != null) {
                destination = value;
                String routeKey = '$startLocation-$destination';
                buses = routeBuses[routeKey] ?? [];
                seatPrice = routePrices[routeKey] ?? 2500.0;
                selectedBus = null;

                // Check if this is a premium route
                _isPremiumRoute = (routeKey == 'Colombo-Kandy' ||
                    routeKey == 'Colombo-Galle');
              }
            });
          },
        ),
        const SizedBox(height: 16),
        if (buses.isNotEmpty)
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Select Bus"),
            value: selectedBus,
            items: buses.map((bus) {
              return DropdownMenuItem<String>(value: bus, child: Text(bus));
            }).toList(),
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  selectedBus = value;
                  times = availableTimes[selectedBus] ?? [];
                  selectedTime = null; // Reset time selection
                }
              });
            },
          ),
        const SizedBox(height: 16),
        if (times.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available Times for $selectedBus:",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Select Time"),
                value: selectedTime,
                items: times.map((time) {
                  return DropdownMenuItem<String>(
                      value: time, child: Text(time));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedTime = value;
                    }
                  });
                },
              ),
            ],
          ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2026),
            );
            if (pickedDate != null) {
              setState(() {
                selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          },
          child: Text("Select Travel Date: $selectedDate"),
        ),

        // Calendar integration for planning trips
        const SizedBox(height: 16),
        CheckboxListTile(
          title: const Text("Add trip to calendar"),
          value: _showCalendarIntegration,
          onChanged: (value) {
            setState(() {
              _showCalendarIntegration = value ?? false;
            });
          },
        ),

        if (_showCalendarIntegration)
          Card(
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Calendar Integration",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("Trip will be added to your calendar with:"),
                  const SizedBox(height: 4),
                  Text("• Date: $selectedDate"),
                  if (selectedTime != null) Text("• Time: $selectedTime"),
                  if (startLocation != null && destination != null)
                    Text("• Journey: $startLocation to $destination"),
                  const SizedBox(height: 8),
                  const Text(
                      "Reminders will be set for 1 day and 2 hours before departure."),
                ],
              ),
            ),
          ),

        // Future stop capacity prediction
        if (startLocation != null && destination != null)
          Card(
            color: Colors.orange.shade50,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Stop Capacity Prediction",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                      "$startLocation: ${_stopCapacityPrediction[startLocation]}% full"),
                  LinearProgressIndicator(
                    value: (_stopCapacityPrediction[startLocation] ?? 0) / 100,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        (_stopCapacityPrediction[startLocation] ?? 0) > 80
                            ? Colors.red
                            : Colors.green),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      "$destination: ${_stopCapacityPrediction[destination]}% full"),
                  LinearProgressIndicator(
                    value: (_stopCapacityPrediction[destination] ?? 0) / 100,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        (_stopCapacityPrediction[destination] ?? 0) > 80
                            ? Colors.red
                            : Colors.green),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      "Tip: Traveling during off-peak times may be more comfortable."),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toggle for bus interior view
        SwitchListTile(
          title: const Text("Show Bus Interior"),
          subtitle: const Text("View actual seat layout"),
          value: _showBusInterior,
          onChanged: (value) {
            setState(() {
              _showBusInterior = value;
            });
          },
        ),

        // Visual picture of the interior of the bus
        if (_showBusInterior)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                // Bus outline
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        // Driver area
                        Container(
                          width: 50,
                          height: 30,
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(child: Text("Driver")),
                        ),
                        const SizedBox(height: 10),
                        const Text("Front of Bus",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        // Entry door
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 10,
                            height: 40,
                            color: Colors.blue,
                            child: const Center(
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text("Door",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Text indicating this is a visual representation
                const Positioned(
                  bottom: 5,
                  right: 10,
                  child: Text("Interactive seat selection below",
                      style:
                          TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
                ),
              ],
            ),
          ),

        // Priority seating accessibility indicator
        const SizedBox(height: 10),
        const Text("Seat Legend:",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 10,
          children: [
            Chip(
              backgroundColor: Colors.grey,
              label:
                  const Text("Occupied", style: TextStyle(color: Colors.white)),
            ),
            Chip(
              backgroundColor: Colors.blue,
              label: const Text("Available",
                  style: TextStyle(color: Colors.white)),
            ),
            Chip(
              backgroundColor: Colors.amber,
              label:
                  const Text("Window", style: TextStyle(color: Colors.black)),
            ),
            Chip(
              backgroundColor: Colors.red.shade300,
              label:
                  const Text("Priority", style: TextStyle(color: Colors.white)),
            ),
            if (_isPremiumRoute)
              Chip(
                backgroundColor: Colors.purple.shade300,
                label: const Text("Premium",
                    style: TextStyle(color: Colors.white)),
              ),
            Chip(
              backgroundColor: Colors.green,
              label:
                  const Text("Selected", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),

        // Real-time data about available/occupied seats
        const SizedBox(height: 16),
        if (selectedBus != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select your seat for $selectedBus:",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),

              // Seat grid with window seat visualization
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  final seatNumber = index + 1;
                  final isOccupied =
                      occupiedSeats[selectedBus]?.contains(seatNumber) ?? false;
                  final isPriority = prioritySeats.contains(seatNumber);
                  final isPremium = premiumSeats.contains(seatNumber);
                  final isWindow = windowSeats.contains(seatNumber);
                  final isSelected = _selectedSeatIndex == index;

                  Color seatColor = Colors.blue;
                  if (isOccupied) {
                    seatColor = Colors.grey;
                  } else if (isSelected) {
                    seatColor = Colors.green;
                  } else if (isPriority) {
                    seatColor = Colors.red.shade300;
                  } else if (isPremium && _isPremiumRoute) {
                    seatColor = Colors.purple.shade300;
                  } else if (isWindow) {
                    seatColor = Colors.amber;
                  }

                  return GestureDetector(
                    onTap: isOccupied
                        ? null
                        : () {
                            setState(() {
                              _selectedSeatIndex =
                                  (index == _selectedSeatIndex) ? -1 : index;

                              // Adjust price for premium seats
                              if (_isPremiumRoute && isPremium) {
                                seatPrice = (routePrices[
                                            '$startLocation-$destination'] ??
                                        2500.0) *
                                    1.5;
                              } else {
                                seatPrice = routePrices[
                                        '$startLocation-$destination'] ??
                                    2500.0;
                              }
                            });
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: seatColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? Colors.green.shade800
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              "$seatNumber",
                              style: TextStyle(
                                color: (isOccupied ||
                                        isPriority ||
                                        (isPremium && _isPremiumRoute))
                                    ? Colors.white
                                    : isWindow
                                        ? Colors.black
                                        : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isWindow)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),
              if (_selectedSeatIndex != -1)
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Seat: ${_selectedSeatIndex + 1}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              "Seat Price: ${seatPrice.toStringAsFixed(2)} LKR",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        if (windowSeats.contains(_selectedSeatIndex + 1))
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.window, size: 16),
                                SizedBox(width: 8),
                                Text("Window Seat"),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildStepThree() {
    // Calculate total price
    double totalPrice = seatPrice;

    // Apply discount if available
    if (_discountAmount > 0) {
      totalPrice -= _discountAmount;
    }

    // Calculate wallet benefit if used
    double walletBenefit = 0.0;
    if (useWallet) {
      walletBenefit = walletBalance > totalPrice ? totalPrice : walletBalance;
      totalPrice -= walletBenefit;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Colors.blue.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Booking Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Divider(),
                const SizedBox(height: 8),
                if (startLocation != null && destination != null)
                  Row(
                    children: [
                      const Icon(Icons.swap_horiz, size: 16),
                      const SizedBox(width: 8),
                      Text("$startLocation to $destination"),
                    ],
                  ),
                const SizedBox(height: 4),
                if (selectedBus != null)
                  Row(
                    children: [
                      const Icon(Icons.directions_bus, size: 16),
                      const SizedBox(width: 8),
                      Text("Bus: $selectedBus"),
                    ],
                  ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 8),
                    Text("Date: $selectedDate"),
                  ],
                ),
                const SizedBox(height: 4),
                if (selectedTime != null)
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 8),
                      Text("Time: $selectedTime"),
                    ],
                  ),
                const SizedBox(height: 4),
                if (_selectedSeatIndex != -1)
                  Row(
                    children: [
                      const Icon(Icons.event_seat, size: 16),
                      const SizedBox(width: 8),
                      Text("Seat: ${_selectedSeatIndex + 1}"),
                    ],
                  ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Ticket Price:"),
                    Text("${seatPrice.toStringAsFixed(2)} LKR"),
                  ],
                ),
                if (_discountAmount > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Discount:"),
                      Text("-${_discountAmount.toStringAsFixed(2)} LKR"),
                    ],
                  ),
                if (useWallet && walletBenefit > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Wallet Credit:"),
                      Text("-${walletBenefit.toStringAsFixed(2)} LKR"),
                    ],
                  ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${totalPrice.toStringAsFixed(2)} LKR",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
        // Apply discount coupon
        TextField(
          decoration: const InputDecoration(
            labelText: "Enter Promo Code",
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.local_offer),
          ),
          onChanged: (value) {
            // Simulate discount code
            if (value.toUpperCase() == "SAVE10") {
              setState(() {
                _discountAmount = seatPrice * 0.1; // 10% discount
              });
            } else if (value.toUpperCase() == "SAVE20") {
              setState(() {
                _discountAmount = seatPrice * 0.2; // 20% discount
              });
            } else {
              setState(() {
                _discountAmount = 0.0;
              });
            }
          },
        ),

        const SizedBox(height: 16),
        // Option to use wallet
        SwitchListTile(
          title: const Text("Use My Wallet"),
          subtitle: Text("Balance: ${walletBalance.toStringAsFixed(2)} LKR"),
          value: useWallet,
          onChanged: (bool value) {
            setState(() {
              useWallet = value;
            });
          },
        ),

        const SizedBox(height: 16),
        // Save payment method
        CheckboxListTile(
          title: const Text("Use stored payment method"),
          subtitle: const Text("Visa •••• 4321"),
          value: _useStoredPayment,
          onChanged: (value) {
            setState(() {
              _useStoredPayment = value ?? false;
            });
          },
        ),

        if (!_useStoredPayment)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Payment Information",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              // Card number field
              TextField(
                decoration: const InputDecoration(
                  labelText: "Card Number",
                  hintText: "XXXX XXXX XXXX XXXX",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              const SizedBox(height: 12),
              // Expiry and CVV
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Expiry Date",
                        hintText: "MM/YY",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "CVV",
                        hintText: "XXX",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Name on card
              TextField(
                decoration: const InputDecoration(
                  labelText: "Name on Card",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),

        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4B5EFC),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _selectedSeatIndex == -1
                ? null
                : () {
                    // Implement booking logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Booking confirmed! E-ticket sent to your email."),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
            child: const Text(
              "Confirm Booking",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
