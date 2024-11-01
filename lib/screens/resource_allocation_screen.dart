import 'package:flutter/material.dart';

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
                      'Incident Type:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Fire', // Replace with dynamic value
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text('Location: 123 Main St, Cityville'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Reported at: June 20, 2023 15:45'), // Replace with dynamic value
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Resource Allocation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
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
            Text(
              'Additional Resources',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            _switchTile(
              'Police Units',
              policeUnits,
              onChanged: (value) => setState(() {
                policeUnits = value;
              }),
            ),
            _switchTile(
              'Hazmat Team',
              hazmatTeam,
              onChanged: (value) => setState(() {
                hazmatTeam = value;
              }),
            ),
            _switchTile(
              'Search and Rescue',
              searchAndRescue,
              onChanged: (value) => setState(() {
                searchAndRescue = value;
              }),
            ),
            SizedBox(height: 20),
            Text(
              'Special Instructions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter any special instructions for the rescue team',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.green,
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

  Widget _resourceRow(
      String resourceName, int currentValue, int maxValue, {required VoidCallback onDecrease, required VoidCallback onIncrease}) {
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

  Widget _switchTile(String title, bool value, {required ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  void _dispatchResources() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resources Dispatched'),
        content: Text('The team has received the resources and is now on action.'),
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
