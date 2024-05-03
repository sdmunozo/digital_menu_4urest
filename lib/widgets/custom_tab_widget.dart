import 'package:flutter/material.dart';

class CustomTabWidget extends StatelessWidget {
  const CustomTabWidget(
      {super.key, required this.title, required this.isActive});

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 11),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: isActive ? Colors.orange : Colors.black,
          ),
        ),
      ),
    );
  }
}
