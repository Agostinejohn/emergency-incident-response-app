import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResourceAllocationScreen extends StatefulWidget {
  @override
  _ResourceAllocationScreenState createState() =>
      _ResourceAllocationScreenState();
}

class _ResourceAllocationScreenState extends State<ResourceAllocationScreen> {
  int fireTrucks = 3;
  int firefighters = 12;
  int ambulances = 2;
  bool policeUnits = true;
  bool hazmatTeam = true;
  bool searchAndRescue = true;

  String incidentType = '';
  String location = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    incidentType =
        args['incidentType'] ?? 'Unknown'; // Provide a default value if null
    location = args['location'] ?? 'Unknown'; // Provide a default value if null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Overview'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Incident Type: $incidentType',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Location: $location'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Resource Allocation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            _resourceRow(
              'Fire Trucks',
              fireTrucks,
              5,
              onDecrease: () => setState(() {
                if (fireTrucks > 0) fireTrucks--;
              }),
              onIncrease: () => setState(() {
                if (fireTrucks < 5) fireTrucks++;
              }),
            ),
            _resourceRow(
              'Firefighters',
              firefighters,
              20,
              onDecrease: () => setState(() {
                if (firefighters > 0) firefighters--;
              }),
              onIncrease: () => setState(() {
                if (firefighters < 20) firefighters++;
              }),
            ),
            _resourceRow(
              'Ambulances',
              ambulances,
              3,
              onDecrease: () => setState(() {
                if (ambulances > 0) ambulances--;
              }),
              onIncrease: () => setState(() {
                if (ambulances < 3) ambulances++;
              }),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: _dispatchResources,
                child: Text('Dispatch Resources'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resourceRow(String resourceName, int currentValue, int maxValue,
      {required VoidCallback onDecrease, required VoidCallback onIncrease}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(resourceName),
            Spacer(),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: onDecrease,
            ),
            Text(currentValue.toString()),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: onIncrease,
            ),
            Text('Available: $maxValue'),
          ],
        ),
      ),
    );
  }

  void _dispatchResources() async {
    // Save resource allocations to Firestore
    final resourcesData = {
      'incidentType': incidentType,
      'location': location,
      'fireTrucks': fireTrucks,
      'firefighters': firefighters,
      'ambulances': ambulances,
      'policeUnits': policeUnits,
      'hazmatTeam': hazmatTeam,
      'searchAndRescue': searchAndRescue,
      'timestamp':
          FieldValue.serverTimestamp(), // Optional: timestamp of allocation
    };

    // Save resource allocation to Firestore
    await FirebaseFirestore.instance
        .collection('resource_allocations')
        .add(resourcesData);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resources Dispatched'),
        content:
            Text('The team has received the resources and is now in action.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
