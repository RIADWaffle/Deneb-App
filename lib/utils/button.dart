import 'package:flutter/material.dart';

class ButtonR extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ButtonR({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 240, 210, 129),
            minimumSize: const Size(500, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
