import 'package:digital_menu_4urest/models/item_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowItemModalWidget extends StatelessWidget {
  const ShowItemModalWidget({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    const priceTextStyle = TextStyle(
      color: Colors.green,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    return Dialog(
      insetPadding: const EdgeInsets.only(top: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(
        height: GlobalConfigProvider.maxHeight,
        width: GlobalConfigProvider.maxWidth,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: GlobalConfigProvider.backgroundColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    height: (GlobalConfigProvider.maxHeight * 0.5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CustomImageProvider.getNetworkImageIP(item.icon),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.7),
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5),
                    child: Text(
                      item.alias,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, bottom: 5, right: 15),
                    child: Text(
                      item.description,
                      style: const TextStyle(
                        color: Color(0xff88888a),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const CustomDividerWidget(),
                  if (item.modifiersGroups.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Personalizalo a tu gusto",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: item.modifiersGroups.length,
                      itemBuilder: (context, index) {
                        final group = item.modifiersGroups[index];
                        return ListTile(
                          title: Text(
                            group.alias,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: group.modifiers.length,
                            itemBuilder: (context, modIndex) {
                              final modifier = group.modifiers[modIndex];
                              return Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16.0),
                                    child: Icon(Icons.circle, size: 10),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    modifier.alias,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    (modifier.price.isNotEmpty &&
                                            modifier.price != '0')
                                        ? "\$${double.parse(modifier.price).toStringAsFixed(2)}"
                                        : '',
                                    style: priceTextStyle,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
