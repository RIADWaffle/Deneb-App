// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DropDownR extends StatefulWidget {
  final Function(String) onItemSelected;
  const DropDownR({super.key, required this.onItemSelected});

  @override
  State<DropDownR> createState() => _DropDownRState();
}

class _DropDownRState extends State<DropDownR> {
  String dropdownValue = "Gas";

//Gas, líquido, sólido o rocoso)
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
            value: 'Gas',
            child: Text('Gas'),
          ),
          DropdownMenuItem(
            value: 'Liquid',
            child: Text('Liquid'),
          ),
          DropdownMenuItem(
            value: 'Solid',
            child: Text('Solid'),
          ),
          DropdownMenuItem(
            value: 'Rocky',
            child: Text('Rocky'),
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
