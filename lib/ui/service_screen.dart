import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your Google Map widget here (use the example from the previous code)
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Open Bottom Sheet
                _showBottomSheet(context);
              },
              child: Text('Open Bottom Sheet'),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show bottom sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return _buildBottomSheetContent(context);
      },
    );
  }

  // Function to build the bottom sheet content
  Widget _buildBottomSheetContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.motorcycle, color: Colors.blue),
            title: Text('Passenger'),
            subtitle: Text('Safely ride a motorcycle taxi'),
          ),
          ListTile(
            leading: Icon(Icons.local_shipping, color: Colors.brown),
            title: Text('Padala'),
            subtitle: Text('Send packages & other supplies'),
          ),
          ListTile(
            leading: Icon(Icons.directions_car, color: Colors.green),
            title: Text('Angcars'),
            subtitle: Text('Car Ride with maximum 4 passengers'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Show Dialog
              _showServiceDialog(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.directions_bike),
                SizedBox(width: 8),
                Text('Choose Service'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the dialog once the button is clicked
  void _showServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Service Selection"),
          content: Text("You have selected a service."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
