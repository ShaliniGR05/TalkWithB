import 'package:flutter/material.dart';
import 'msg.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1CCE5), // Set the background color
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFFA594DE), // Optionally set AppBar color
        elevation: 0, // Remove shadow
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Button (Phone Icon)
            SizedBox(
              width: 200, // Set width for the button
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA594DE), // Button background color
                  foregroundColor: Colors.black, // Text color
                  padding: EdgeInsets.symmetric(vertical: 15), // Vertical padding
                  textStyle: TextStyle(fontSize: 16, fontFamily: 'InriaSans'), // Text style
                  elevation: 4, // Button elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Button radius
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.phone), // Phone icon
                label: Text("Phone"),
              ),
            ),
            SizedBox(height: 50), // Space between buttons

            // Second Button (Message Icon)
            SizedBox(
              width: 200, // Set width for the button
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA594DE), // Button background color
                  foregroundColor: Colors.black, // Text color
                  padding: EdgeInsets.symmetric(vertical: 15), // Vertical padding
                  textStyle: TextStyle(fontSize: 16, fontFamily: 'InriaSans'), // Text style
                  elevation: 4, // Button elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Button radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BluetoothApp()),
                  );
                },
                icon: Icon(Icons.message), // Message icon
                label: Text("Message"),
              ),
            ),
            SizedBox(height: 50), // Space between buttons

            // Third Button (File Icon)
            SizedBox(
              width: 200, // Set width for the button
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA594DE), // Button background color
                  foregroundColor: Colors.black, // Text color
                  padding: EdgeInsets.symmetric(vertical: 15), // Vertical padding
                  textStyle: TextStyle(fontSize: 16, fontFamily: 'InriaSans'), // Text style
                  elevation: 4, // Button elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Button radius
                  ),
                ),
                onPressed: () {},
                icon: Icon(Icons.insert_drive_file), // File icon
                label: Text("File"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remove the debug symbol
    home: HomePage(),
  ));
}
