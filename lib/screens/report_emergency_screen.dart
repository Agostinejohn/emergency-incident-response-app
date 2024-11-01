import 'package:flutter/material.dart';
import 'emergency_reported_screen.dart'; // Import the Emergency Reported screen
import 'package:image_picker/image_picker.dart'; // For selecting an image

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
  final List<String> casualtyCounts = ['1', '2', '3', '4', '5', '<10', '<15', 'Many'];

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
          child: SingleChildScrollView( // Allows for scrolling
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
                  validator: (value) => value == null ? 'Please select an incident type' : null,
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
                      if (selectedIncidentType == 'Other' && (value == null || value.isEmpty)) {
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
                  onTap: _selectLocation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
                            style: TextStyle(color: incidentLocation == null ? Colors.grey : Colors.black),
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
                    validator: (value) => hasCasualties && value == null ? 'Please select the number of casualties' : null,
                  ),
                  const SizedBox(height: 16),
                ],
                
                // Image Upload Section
                const Text('Add Photo (Optional)'),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _selectImage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
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
                            incidentImage == null ? 'Upload Incident Photo' : 'Photo Added',
                            style: TextStyle(color: incidentImage == null ? Colors.grey : Colors.black),
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
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      onPressed: _submitReport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
    setState(() {
      incidentLocation = "Selected Location"; // Mock location for now
    });
  }

  // Function to pick an image using ImagePicker
  Future<void> _selectImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      incidentImage = pickedImage;
    });
  }

  // Function to submit the report with validation and navigation to Emergency Reported Screen
  void _submitReport() {
    if (selectedIncidentType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an incident type')),
      );
      return;
    }

    if (selectedIncidentType == 'Other' && (otherIncidentDescription == null || otherIncidentDescription!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please specify your type of emergency')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmergencyReportedScreen()),
      );
    }
  }
}
