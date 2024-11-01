import 'package:flutter/material.dart';

class EmergencyStatusScreen extends StatelessWidget {
  final String incidentType;
  final String reportedTime;

  const EmergencyStatusScreen({super.key, required this.incidentType, required this.reportedTime});

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
            // Header section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Incident Type:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Incident type icon (change dynamically based on the incident)
                      CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: Icon(
                          _getIncidentIcon(incidentType),  // Use function to get relevant icon
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Incident type label (dynamic)
                      Text(
                        incidentType,  // Dynamic incident type
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Reported at:',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    reportedTime,  // Dynamic reported time
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Text(
                        'Status:',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Chip(
                        label: Text(
                          'In Progress',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Status Timeline section
            const Text(
              'Status Timeline',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  StatusTimelineTile(
                    statusText: 'Emergency Reported',
                    statusDetail:
                        'Your emergency has been successfully reported and logged in our system.',
                    statusIcon: Icons.check_circle,
                    isCompleted: true,
                  ),
                  StatusTimelineTile(
                    statusText: 'Dispatch Notified',
                    statusDetail:
                        'Emergency services have been alerted and are preparing to respond.',
                    statusIcon: Icons.check_circle,
                    isCompleted: true,
                  ),
                  StatusTimelineTile(
                    statusText: 'Units En Route',
                    statusDetail:
                        'Emergency response units are on their way to your location.',
                    statusIcon: Icons.directions_car,
                    isCompleted: true,
                  ),
                  StatusTimelineTile(
                    statusText: 'On Scene',
                    statusDetail: 'Responders arrive at the emergency location.',
                    statusIcon: Icons.location_on,
                    isCompleted: false,
                  ),
                  StatusTimelineTile(
                    statusText: 'Situation Resolved',
                    statusDetail: 'Emergency has been addressed and resolved.',
                    statusIcon: Icons.check_circle_outline,
                    isCompleted: false,
                  ),
                ],
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
      default:
        return Icons.warning;
    }
  }
}

// StatusTimelineTile widget remains the same.
class StatusTimelineTile extends StatelessWidget {
  final String statusText;
  final String statusDetail;
  final IconData statusIcon;
  final bool isCompleted;

  const StatusTimelineTile({super.key, 
    required this.statusText,
    required this.statusDetail,
    required this.statusIcon,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            statusIcon,
            color: isCompleted ? Colors.green : Colors.grey,
            size: 30.0,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  statusDetail,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isCompleted ? Colors.black87 : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
