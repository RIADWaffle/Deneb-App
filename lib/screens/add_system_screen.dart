// ignore_for_file: prefer_const_constructors

import 'package:deneb/utils/button.dart';
import 'package:flutter/material.dart';
import '../class/database_helper.dart';
import '../class/planetary_system.dart';

class AddSystemScreen extends StatefulWidget {
  @override
  _AddSystemScreenState createState() => _AddSystemScreenState();
}

class _AddSystemScreenState extends State<AddSystemScreen> {
  final TextEditingController _systemNameController = TextEditingController();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 230, 187),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 230, 187),
        title: Text('Add System'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Name:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _systemNameController,
              decoration: InputDecoration(
                hintText: 'Enter system name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors
                          .black), // Puedes personalizar el color del borde
                  borderRadius: BorderRadius.all(Radius.circular(
                      8.0)), // Puedes ajustar el radio del borde
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonR(
                  title: "add system",
                  onPressed: () async {
                    // Validate and save the system to the database
                    if (_systemNameController.text.isNotEmpty) {
                      await databaseHelper.insertSystem(
                        PlanetarySystem(name: _systemNameController.text),
                      );
                      Navigator.pop(context); // Go back to the previous screen
                    } else {
                      // Show error message if necessary
                      // You can add additional validation logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a system name.'),
                        ),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
