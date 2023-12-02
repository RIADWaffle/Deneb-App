// ignore_for_file: prefer_const_constructors

import 'package:deneb/utils/button.dart';
import 'package:deneb/utils/system_card.dart';
import 'package:flutter/material.dart';
import '../class/database_helper.dart';
import '../class/planetary_system.dart';
import 'planet_list_screen.dart';
import 'add_system_screen.dart';

class SystemListScreen extends StatefulWidget {
  @override
  _SystemListScreenState createState() => _SystemListScreenState();
}

class _SystemListScreenState extends State<SystemListScreen> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 230, 187),
      appBar: AppBar(
        title: Text(
          'Systems',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 245, 230, 187),
      ),
      body: FutureBuilder<List<PlanetarySystem>>(
        future: databaseHelper.getAllSystems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              children: [
                Text('No systems found.'),
                ButtonR(
                    title: "Add system",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddSystemScreen(),
                        ),
                      ).then((value) {
                        // Refresh the list after adding a system
                        setState(() {});
                      });
                    }),
              ],
            );
          } else {
            return _buildSystemList(context, snapshot.data!);
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  Widget _buildSystemList(BuildContext context, List<PlanetarySystem> systems) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .68,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: systems.length,
            itemBuilder: (context, index) {
              return SystemCard(
                  title: systems[index].name,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlanetListScreen(system: systems[index]),
                      ),
                    );
                  });
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ButtonR(
            title: "Add system",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSystemScreen(),
                ),
              ).then((value) {
                // Refresh the list after adding a system
                setState(() {});
              });
            }),
      ],
    );
  }
}
