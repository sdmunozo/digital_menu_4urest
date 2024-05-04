import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategorySectionBoldTitle extends StatelessWidget {
  const CategorySectionBoldTitle(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 5, right: 15),
          child: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff88888a),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
