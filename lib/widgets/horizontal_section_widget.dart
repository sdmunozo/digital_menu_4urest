import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/section_vertical_article.dart';
import 'package:flutter/material.dart';

class HorizontalSectionWidget extends StatelessWidget {
  const HorizontalSectionWidget(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: GlobalConfigProvider.maxWidth,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                  child: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff88888a),
                      fontSize: 10,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      SectionVerticalArticle(
                        title: "McTrío Mediano McNuggets 10 McNuggets 10",
                        image: "url",
                        price: "135",
                      ),
                      SectionVerticalArticle(
                        title: "McTrío Mediano McNuggets 10 McNuggets 10",
                        image: "url",
                        price: "135",
                      ),
                      SectionVerticalArticle(
                        title: "McTrío Mediano McNuggets 10 McNuggets 10",
                        image: "url",
                        price: "135",
                      ),
                      SectionVerticalArticle(
                        title: "McTrío Mediano McNuggets 10 McNuggets 10",
                        image: "url",
                        price: "135",
                      ),
                      SectionVerticalArticle(
                        title: "McTrío Mediano McNuggets 10 McNuggets 10",
                        image: "url",
                        price: "135",
                      ),
                      SectionVerticalArticle(
                        title: "McTrío Mediano McNuggets 10 McNuggets 10",
                        image: "url",
                        price: "135",
                      ),
                      SizedBox(
                        width: 13,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
            child: Container(
              width: GlobalConfigProvider.maxWidth,
              height: 1,
              decoration: BoxDecoration(
                color: const Color.fromARGB(45, 136, 136, 138),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
