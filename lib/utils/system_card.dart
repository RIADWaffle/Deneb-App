import 'package:flutter/material.dart';

class SystemCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SystemCard({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        color: Color.fromARGB(255, 240, 210, 129),
        child: ListTile(
          title: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    "https://i.pinimg.com/564x/63/2c/54/632c5486a48e75eec14ae8bb2ba1fa57.jpg"),
              ),
            ],
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}
