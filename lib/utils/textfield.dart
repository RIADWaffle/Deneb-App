// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldR extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final TextInputType type;

  const TextFieldR(
      {super.key,
      required this.title,
      required this.hint,
      required this.controller,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        TextField(
          keyboardType: type,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      Colors.black), // Puedes personalizar el color del borde
              borderRadius: BorderRadius.all(
                  Radius.circular(8.0)), // Puedes ajustar el radio del borde
            ),
          ),
        ),
      ],
    );
  }
}
