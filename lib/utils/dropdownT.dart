// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DropDownType extends StatefulWidget {
  final Function(String) onItemSelected;
  const DropDownType({super.key, required this.onItemSelected});

  @override
  State<DropDownType> createState() => _DropDownTypeState();
}

class _DropDownTypeState extends State<DropDownType> {
  String dropdownValue = "Sistem";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(171, 0, 0,
                0)), // Ajusta el color del borde según tus necesidades
        borderRadius:
            BorderRadius.all(Radius.circular(8.0)), // Ajusta el radio del borde
      ),
      child: DropdownButton<String>(
        value: dropdownValue, // Valor seleccionado
        items: [
          DropdownMenuItem(
            value: 'Sistem',
            child: Text('Sistem'),
          ),
          DropdownMenuItem(
            value: 'Star',
            child: Text('Star'),
          ),
          DropdownMenuItem(
            value: 'Planet',
            child: Text('Planet'),
          ),
          DropdownMenuItem(
            value: 'Asteroid',
            child: Text('Asteroid'),
          ),
          DropdownMenuItem(
            value: 'Comet',
            child: Text('Comet'),
          ),
          DropdownMenuItem(
            value: 'Unknow',
            child: Text('Unknow'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            dropdownValue = value!;
            widget.onItemSelected(
                dropdownValue); // Llama al callback con el valor seleccionado
          });
        },
      ),
    );
  }
}

//Unknow | Comet | Asteroid | Planet | Star | Sistem