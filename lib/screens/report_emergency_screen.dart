import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:image_picker/image_picker.dart'; // For selecting an image
import 'dart:io'; // For using File
import 'emergency_reported_screen.dart'; // Import the Emergency Reported screen

class ReportEmergencyScreen extends StatefulWidget {
  const ReportEmergencyScreen({super.key});

  @override
  _ReportEmergencyScreenState createState() => _ReportEmergencyScreenState();
}

class _ReportEmergencyScreenState extends State<ReportEmergencyScreen> {
  // Variables for incident type, description, location, and casualties
  String? selectedIncidentType;
  String? otherIncidentDescription; // Description for "Other" incident type
  String? incidentDescription;
  String? incidentLocation;
  bool hasCasualties = false; // Checkbox value for casualties
  String? selectedCasualtyCount; // Casualty count selection
  XFile? incidentImage; // Image for the incident

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // List of incident types for the dropdown
  final List<String> incidentTypes = [
    'Fire',
    'Medical',
    'Crime',
    'Natural Disaster',
    'Floods',
    'Police',
    'Terrorism',
    'Ambulance',
    'Other'
  ];

  // List for casualties count options
  final List<String> casualtyCounts = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '<10',
    '<15',
    'Many'
  ];

  // List of predefined locations
  final List<String> predefinedLocations = [
    'Kampi ya Moto, Kabarak',
    'Nakuru',
    'Naivasha, Mercy Njeri',
    'Nairobi, CBD',
    'Eldoret, Town Center',
  ];

  // Image picker for uploading an image
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade800,
        title: const Text('Report an Emergency'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Allows for scrolling
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please provide details about the emergency situation. Your quick and accurate report can help save lives.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 16),

                // Incident Type Dropdown
                const Text('Incident Type'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedIncidentType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedIncidentType = newValue;
                      if (selectedIncidentType != 'Other') {
                        otherIncidentDescription = null;
                      }
                    });
                  },
                  items: incidentTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value == null ? 'Please select an incident type' : null,
                ),
                const SizedBox(height: 16),

                // Additional text field for "Other" incident type
                if (selectedIncidentType == 'Other') ...[
                  const Text('Please specify the type of emergency'),
                  const SizedBox(height: 8),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        otherIncidentDescription = value;
                      });
                    },
                    validator: (value) {
                      if (selectedIncidentType == 'Other' &&
                          (value == null || value.isEmpty)) {
                        return 'Please specify your type of emergency';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Specify your emergency type',
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Location Section
                const Text('Location'),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _selectLocation, // Call the method to select location
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            incidentLocation ?? 'Select Incident Location',
                            style: TextStyle(
                                color: incidentLocation == null
                                    ? Colors.grey
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Description Section
                const Text('Description'),
                const SizedBox(height: 8),
                TextFormField(
                  maxLines: 5,
                  onChanged: (value) {
                    setState(() {
                      incidentDescription = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Briefly describe the emergency situation',
                  ),
                ),
                const SizedBox(height: 16),

                // Casualties Checkbox and Dropdown
                Row(
                  children: [
                    Checkbox(
                      value: hasCasualties,
                      onChanged: (bool? value) {
                        setState(() {
                          hasCasualties = value ?? false;
                          if (!hasCasualties) {
                            selectedCasualtyCount = null;
                          }
                        });
                      },
                    ),
                    const Text('Are there any casualties?'),
                  ],
                ),
                const SizedBox(height: 8),

                // Casualty Count Dropdown
                if (hasCasualties) ...[
                  const Text('Number of Casualties'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedCasualtyCount,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCasualtyCount = newValue;
                      });
                    },
                    items: casualtyCounts.map((String count) {
                      return DropdownMenuItem<String>(
                        value: count,
                        child: Text(count),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) => hasCasualties && value == null
                        ? 'Please select the number of casualties'
                        : null,
                  ),
                  const SizedBox(height: 16),
                ],

                // Image Upload Section
                const Text('Add Photo (Optional)'),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _selectImage,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.camera_alt, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            incidentImage == null
                                ? 'Upload Incident Photo'
                                : 'Photo Added',
                            style: TextStyle(
                                color: incidentImage == null
                                    ? Colors.grey
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Buttons for submission and back navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      onPressed: _submitReport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to select location
  void _selectLocation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a Location'),
          content: SingleChildScrollView(
            child: ListBody(
              children: predefinedLocations.map((location) {
                return ListTile(
                  title: Text(location),
                  onTap: () {
                    setState(() {
                      incidentLocation = location; // Set selected location
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Function to pick an image using ImagePicker
  Future<void> _selectImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      incidentImage = pickedImage;
    });
  }

  // Function to submit the report with validation and Firestore integration
  Future<void> _submitReport() async {
    if (selectedIncidentType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an incident type')),
      );
      return;
    }

    if (selectedIncidentType == 'Other' &&
        (otherIncidentDescription == null ||
            otherIncidentDescription!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please specify your type of emergency')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      String? imageUrl;

      // Upload image to Firebase Storage if an image is selected
      if (incidentImage != null) {
        try {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('emergency_images/${incidentImage!.name}');
          await storageRef.putFile(File(
              incidentImage!.path)); // Ensure you import 'dart:io' to use File
          imageUrl = await storageRef.getDownloadURL(); // Get the download URL
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error uploading image: $e')),
          );
        }
      }

      // Create a report data object
      final reportData = {
        'incidentType': selectedIncidentType == 'Other'
            ? otherIncidentDescription
            : selectedIncidentType,
        'description': incidentDescription,
        'location': incidentLocation,
        'hasCasualties': hasCasualties,
        'casualtyCount': selectedCasualtyCount,
        'imageUrl': imageUrl, // Store the image URL
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
      };

      try {
        // Submit the report to Firestore
        await FirebaseFirestore.instance
            .collection('emergency_reports')
            .add(reportData);

        // Navigate to Emergency Reported Screen upon successful submission
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const EmergencyReportedScreen()),
        );
      } catch (e) {
        // Handle any errors that occur during submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting report: $e')),
        );
      }
    }
  }
}
