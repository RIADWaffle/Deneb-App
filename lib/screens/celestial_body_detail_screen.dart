// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:deneb/assets/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import '../class/celestial_body.dart';
import '../class/database_helper.dart';

class CelestialBodyDetailScreen extends StatelessWidget {
  final CelestialBody celestialBody;

  CelestialBodyDetailScreen({required this.celestialBody});

  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 230, 187),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 230, 187),
        title: Text(
          celestialBody.name,
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          _buildPopupMenuButton(context),
        ],
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildInfoCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Color.fromARGB(255, 240, 210, 129),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                celestialBody.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _natureInfo(celestialBody.majorityNature),
                _typeInfo(celestialBody.type),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            _buildInfoRow('Size: ', '${celestialBody.sizeInKm} km'),
            _buildInfoRow(
              'Distance from Earth: ',
              '${celestialBody.distanceFromEarth} million km',
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  "Description:",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  celestialBody.description,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    if (celestialBody.imagePath.isNotEmpty) {
      File imageFile = File(celestialBody.imagePath);
      if (imageFile.existsSync()) {
        return Image.file(
          imageFile,
          height: 250,
          width: double.infinity,
        );
      }
    }
    return Container(); // Placeholder si no hay imagen
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

// NATURE INFO
  Widget _natureInfo(String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Nature: ",
          style: TextStyle(color: Colors.black),
        ),
        if (value == "Gas") Icon(CustomIcons.gas),
        if (value == "Liquid") Icon(CustomIcons.liquid),
        if (value == "Solid") Icon(Icons.terrain),
        if (value == "Rocky") Icon(CustomIcons.rocky),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // type INFO //Unknow | Comet | Asteroid | Planet | Star | Sistem
  Widget _typeInfo(String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Type: ",
          style: TextStyle(color: Colors.black),
        ),
        if (value == "Sistem") Icon(CustomIcons.system),
        if (value == "Star") Icon(Icons.star),
        if (value == "Planet") Icon(Icons.public),
        if (value == "Asteroid") Icon(CustomIcons.asteroid),
        if (value == "Comet") Icon(CustomIcons.comet),
        if (value == "Unknow") Icon(Icons.question_mark),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      color: const Color.fromARGB(255, 240, 210, 129),
      onSelected: (value) {
        if (value == 'delete') {
          _handleDelete(context);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
    );
  }

  void _handleDelete(BuildContext context) async {
    await databaseHelper.deleteCelestialBody(celestialBody.id!);
    Navigator.pop(context, celestialBody);
  }
}
