import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/widgets/category_section_header.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:digital_menu_4urest/widgets/section_horizontal_item.dart';
import 'package:flutter/material.dart';

class VerticalSectionWidget extends StatelessWidget {
  const VerticalSectionWidget({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 7.5,
        ),
        CategorySectionHeader(
          title: category.name,
          description: category.description,
        ),
        Column(
          children: category.products.map((item) {
            return SectionHorizontalItem(
              item: item,
              calledFrom: "HomeScreen",
            );
          }).toList(),
        ),
        const CustomDividerWidget(),
      ],
    );
  }
}

/*
import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/widgets/category_section_header.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:digital_menu_4urest/widgets/section_horizontal_item.dart';
import 'package:flutter/material.dart';

class VerticalSectionWidget extends StatelessWidget {
  const VerticalSectionWidget({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 7.5,
        ),
        CategorySectionHeader(
          title: category.name,
          description: category.description,
        ),
        Column(
          children: category.products.map((item) {
            return SectionHorizontalItem(
              title: item.alias,
              description: item.description,
              image: item.icon,
              price: item.price,
            );
          }).toList(),
        ),
        const CustomDividerWidget(),
      ],
    );
  }
}

*/