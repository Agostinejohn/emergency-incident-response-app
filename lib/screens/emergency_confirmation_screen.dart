import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting

class EmergencyConfirmationScreen extends StatelessWidget {
  const EmergencyConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    String currentTime = DateFormat('MMMM d, yyyy h:mm a')
        .format(DateTime.now()); // Format current time

    // Sample data for display (you can replace this with actual data if needed)
    String incidentType = "Medical"; // Example incident type
    int casualtyCount = 2; // Example casualty count
    bool hasCasualties = true; // Example casualty status
    String location = "123 Main St"; // Example location
    String description =
        "This is a test emergency report."; // Example description

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: const Text('Emergency Confirmation'), // Screen title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Incident Type, Reported At, Status card
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Incident Type:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Chip(
                            label: Text(incidentType),
                            backgroundColor: Colors.purple.shade100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Reported at:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(currentTime), // Display current time
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Status:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Chip(
                            label: const Text('Pending Confirmation'),
                            backgroundColor: Colors.yellow.shade100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Casualty Count:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(casualtyCount
                              .toString()), // Display casualty count
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Has Casualties:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(hasCasualties
                              ? 'Yes'
                              : 'No'), // Display if there are casualties
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Location:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(location), // Display location
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description card
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Officer Notes section
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Officer Notes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Add any additional observations or notes',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Action buttons (Confirm Emergency, False alarm)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Confirm emergency logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Confirm Emergency'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle false alarm logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('False alarm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
