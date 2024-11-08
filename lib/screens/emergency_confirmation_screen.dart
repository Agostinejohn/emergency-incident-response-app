import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:intl/intl.dart'; // Import intl package for date formatting

class EmergencyConfirmationScreen extends StatelessWidget {
  const EmergencyConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: const Text('Emergency Confirmation'), // Screen title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('emergency_reports')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text('No emergency reports available.'));
            }

            final reports = snapshot.data!.docs;

            return ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index]; // Get the DocumentSnapshot
                final reportData = report.data()
                    as Map<String, dynamic>?; // Get the data as a Map

                // Debugging: Log the entire report data
                print("Report Data: ${report.data()}");

                // Safety check for reportData
                if (reportData == null) {
                  return const Center(
                      child: Text('Report data is not available.'));
                }

                final incidentType = reportData['incidentType'] ?? 'Unknown';
                final reportedTime =
                    reportData['timestamp']?.toDate() ?? DateTime.now();
                final formattedTime =
                    DateFormat('MMMM d, yyyy h:mm a').format(reportedTime);
                final casualtyCount = reportData['casualtyCount'] ?? 0;
                final hasCasualties = reportData['hasCasualties'] ?? false;
                final location = reportData['location'] ?? 'Unknown';
                final description =
                    reportData['description'] ?? 'No description provided';

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Incident Type:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Chip(
                                label: Text(incidentType),
                                backgroundColor: Colors.purple.shade100),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Reported at:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(formattedTime), // Display formatted time
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Casualty Count:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(casualtyCount
                                .toString()), // Display casualty count
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Has Casualties:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(hasCasualties
                                ? 'Yes'
                                : 'No'), // Display if there are casualties
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Location:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(location), // Display location
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Description section
                        const Text('Description',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(description, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 16),

                        // Action buttons (Confirm Emergency, False alarm)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _confirmEmergency(
                                    report.id, context); // Use report.id
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
                                _handleFalseAlarm(report.id); // Use report.id
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
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Function to confirm emergency
  Future<void> _confirmEmergency(String reportId, BuildContext context) async {
    // Update the emergency report status in Firestore
    await FirebaseFirestore.instance
        .collection('emergency_reports')
        .doc(reportId)
        .update({
      'status': 'Confirmed', // Update status field to 'Confirmed'
    });

    // Fetch additional details for the emergency
    DocumentSnapshot reportDoc = await FirebaseFirestore.instance
        .collection('emergency_reports')
        .doc(reportId)
        .get();
    final reportData = reportDoc.data() as Map<String, dynamic>?;

    // Safety check for reportData
    if (reportData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching report details.')));
      return;
    }

    // Pass the necessary data to the Resource Allocation Screen
    Navigator.pushNamed(context, '/resourceAllocation', arguments: {
      'incidentType': reportData['incidentType'],
      'location': reportData['location'],
    });
  }

  // Function to handle false alarm
  Future<void> _handleFalseAlarm(String reportId) async {
    // Update the emergency report status in Firestore
    await FirebaseFirestore.instance
        .collection('emergency_reports')
        .doc(reportId)
        .update({
      'status': 'False Alarm', // Update status field to 'False Alarm'
    });
  }
}
