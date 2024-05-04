import 'package:digital_menu_4urest/widgets/category_section_bold_title.dart';
import 'package:flutter/material.dart';

class CategorySectionHeader extends StatelessWidget {
  const CategorySectionHeader(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 97,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 7,
          ),
          CategorySectionBoldTitle(title: title, description: description),
          const SizedBox(
            height: 7.5,
          ),
        ],
      ),
    );
  }
}
