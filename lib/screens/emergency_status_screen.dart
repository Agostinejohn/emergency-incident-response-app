import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyStatusScreen extends StatelessWidget {
  const EmergencyStatusScreen({super.key, required incidentType, required reportedTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Emergency Status',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Submitted Emergency Reports:',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
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

                  final reports = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report =
                          reports[index].data() as Map<String, dynamic>;
                      final incidentType = report['incidentType'] ?? 'Unknown';
                      final reportedTime =
                          report['timestamp']?.toDate().toString() ??
                              'Unknown Time';
                      final status = report['status'] ??
                          'In Progress'; // Assuming you have a status field

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            child: Icon(
                              _getIncidentIcon(incidentType),
                              color: Colors.red,
                            ),
                          ),
                          title: Text(incidentType,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Reported at: $reportedTime\nStatus: $status'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to return appropriate icons based on the incident type
  IconData _getIncidentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Icons.local_fire_department;
      case 'medical':
        return Icons.local_hospital;
      case 'crime':
        return Icons.local_police;
      case 'natural disaster':
        return Icons.warning;
      case 'floods':
        return Icons.water_damage;
      case 'police':
        return Icons.local_police;
      case 'terrorism':
        return Icons.security;
      case 'ambulance':
        return Icons.local_hospital;
      default:
        return Icons.warning; // Fallback icon
    }
  }
}
