import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/category_section_bold_title.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:digital_menu_4urest/widgets/section_vertical_item.dart';
import 'package:flutter/material.dart';

class HorizontalSectionWidget extends StatelessWidget {
  const HorizontalSectionWidget({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: GlobalConfigProvider.maxWidth,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                CategorySectionBoldTitle(
                  title: category.name,
                  description: category.description,
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: category.products.map((item) {
                      return SectionVerticalItem(
                        item: item,
                        calledFrom: "HomeScreen",
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const CustomDividerWidget(),
        ],
      ),
    );
  }
}


/*
import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/category_section_bold_title.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:digital_menu_4urest/widgets/section_vertical_item.dart';
import 'package:flutter/material.dart';

class HorizontalSectionWidget extends StatelessWidget {
  const HorizontalSectionWidget({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: GlobalConfigProvider.maxWidth,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                CategorySectionBoldTitle(
                  title: category.name,
                  description: category.description,
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: category.products.map((item) {
                      return SectionVerticalItem(
                        title: item.alias,
                        description: item.description,
                        image: item.icon,
                        price: item.price,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const CustomDividerWidget(),
        ],
      ),
    );
  }
}


 */