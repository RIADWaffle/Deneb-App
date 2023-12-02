import 'dart:io';

import 'package:flutter/material.dart';

class PlanetCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final String image;
  const PlanetCard(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        color: Color.fromARGB(255, 240, 210, 129),
        child: ListTile(
          title: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(File(image)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}
