// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:deneb/utils/button.dart';
import 'package:deneb/utils/dropdown.dart';
import 'package:deneb/utils/dropdownT.dart';
import 'package:deneb/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../class/celestial_body.dart';
import '../class/database_helper.dart';
import '../class/planetary_system.dart';

class AddCelestialBodyScreen extends StatefulWidget {
  final PlanetarySystem system;

  AddCelestialBodyScreen({required this.system});

  @override
  _AddCelestialBodyScreenState createState() => _AddCelestialBodyScreenState();
}

class _AddCelestialBodyScreenState extends State<AddCelestialBodyScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sizeInKmController = TextEditingController();
  final TextEditingController _distanceFromEarthController =
      TextEditingController();

  File? _image; // Variable para almacenar la imagen seleccionada

  final DatabaseHelper databaseHelper = DatabaseHelper();
  String nature = "Gas";
  String bodyType = "Sistem";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 230, 187),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 230, 187),
        title: Text('Add Celestial Body'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldR(
                controller: _nameController,
                title: "Name:",
                hint: "",
                type: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              TextFieldR(
                controller: _descriptionController,
                title: "Description:",
                hint: "",
                type: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              Center(child: Text("Type:")),
              DropDownType(
                onItemSelected: (bodyTypeC) {
                  bodyType = bodyTypeC;
                },
              ),
              SizedBox(height: 16.0),
              Center(child: Text("Majority of nature:")),
              DropDownR(
                onItemSelected: (natureC) {
                  nature = natureC;
                  // Puedes realizar acciones con el valor seleccionado aquí
                },
              ),
              SizedBox(height: 16.0),
              TextFieldR(
                controller: _sizeInKmController,
                title: "Size in Kilometers:",
                hint: "",
                type: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              TextFieldR(
                controller: _distanceFromEarthController,
                title: "Distance from earth:",
                hint: "",
                type: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              _image == null
                  ? ButtonR(
                      onPressed: () {
                        _getImageFromCamera();
                      },
                      title: "Select Image from Camera",
                    )
                  : Image.file(_image!, height: 100.0),
              SizedBox(height: 16.0),
              ButtonR(
                onPressed: () {
                  _saveCelestialBody(nature, bodyType);
                },
                title: "Save Celestial Body",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _saveCelestialBody(String nature, String bodyType) async {
    // Validar campos antes de guardar
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _sizeInKmController.text.isNotEmpty &&
        _distanceFromEarthController.text.isNotEmpty &&
        _image != null) {
      CelestialBody celestialBody = CelestialBody(
        name: _nameController.text,
        imagePath: _image!.path, // Usar la ruta de la imagen seleccionada
        description: _descriptionController.text,
        type: bodyType,
        majorityNature: nature,
        sizeInKm: double.parse(_sizeInKmController.text),
        distanceFromEarth: double.parse(_distanceFromEarthController.text),
        systemId: widget.system.id,
      );

      await databaseHelper.insertCelestialBody(celestialBody);

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and select an image.'),
        ),
      );
    }
  }
}
