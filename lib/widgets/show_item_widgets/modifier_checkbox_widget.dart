import 'package:digital_menu_4urest/models/digital_menu/base_model_modifier.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/orders/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModifierCheckboxWidget extends StatelessWidget {
  final BaseModelModifier modifier;
  final bool isSelected;
  final bool isEnabled;
  final Function(bool?) onChanged;

  const ModifierCheckboxWidget({
    super.key,
    required this.modifier,
    required this.isSelected,
    required this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEnabled) {
          onChanged(!isSelected);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Container(
          color: const Color.fromARGB(0, 0, 0, 0),
          child: Row(
            children: [
              SizedBox(
                width: modifier.image.isEmpty ? 0 : 40,
                height: 40,
                child: modifier.image.isEmpty
                    ? Container(
                        color: const Color.fromARGB(0, 0, 0, 0),
                      )
                    : GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          width: GlobalConfigProvider.maxWidth *
                                              0.9,
                                          height:
                                              GlobalConfigProvider.maxHeight *
                                                  0.7,
                                          color: Colors.white,
                                          child: Center(
                                            child: Image.network(
                                              modifier.image,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 16,
                                        right: 16,
                                        child: IconButton(
                                          icon: const Icon(Icons.close,
                                              color: Colors.black),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Image.network(modifier.image),
                      ),
              ),
              const SizedBox(width: 5),
              Text(
                modifier.alias,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text("+\$${modifier.price.toStringAsFixed(2)}"),
              const SizedBox(width: 5),
              GetBuilder<ProductController>(
                builder: (controller) {
                  return Checkbox(
                    value: isSelected,
                    onChanged: isEnabled ? onChanged : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/* Respaldo con contraccion y expansion de los grupos de mod

class ModifierCheckboxWidget extends StatelessWidget {
  final ModifierModel modifier;
  final bool isSelected;
  final bool isEnabled;
  final Function(bool?) onChanged;

  const ModifierCheckboxWidget({
    super.key,
    required this.modifier,
    required this.isSelected,
    required this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEnabled) {
          onChanged(!isSelected);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Container(
          color: const Color.fromARGB(0, 0, 0, 0),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image(
                  image: CustomImageProvider.getNetworkImageIP(modifier.image),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                modifier.alias,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                (modifier.price.isNotEmpty && modifier.price != '0')
                    ? "\$${double.parse(modifier.price).toStringAsFixed(2)}"
                    : '',
              ),
              const SizedBox(width: 5),
              GetBuilder<ProductController>(
                builder: (controller) {
                  return Checkbox(
                    value: isSelected,
                    onChanged: isEnabled ? onChanged : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 */