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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isActive ? 0.15 : 0.05),
            blurRadius: isActive ? 6 : 0,
            offset: Offset(0, isActive ? 3 : 0),
          ),
        ],
      ),
      child: Opacity(
        opacity: isActive ? 1.0 : 0.5,
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
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

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


*/