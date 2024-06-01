import 'package:digital_menu_4urest/models/digital_menu/base_model_modifier.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/models/order_product.dart';
import 'package:digital_menu_4urest/models/product_model.dart';
import 'package:digital_menu_4urest/providers/orders/product_controller.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:digital_menu_4urest/widgets/show_item_widgets/modifier_checkbox_widget.dart';
import 'package:digital_menu_4urest/widgets/show_item_widgets/modifier_radio_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductModifiersListWidget extends StatelessWidget {
  final BaseModelProduct product;
  final Function(bool, OrderProduct) onSelectionChanged;

  const ProductModifiersListWidget({
    super.key,
    required this.product,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    for (var group in product.modifiersGroups) {
      if (!controller.selectedModifiers.containsKey(group.id)) {
        controller.selectedModifiers[group.id] = <String>{};
      }
    }

    return Column(
      children: [
        ...product.modifiersGroups.map((group) {
          return GetBuilder<ProductController>(
            builder: (_) {
              bool isExpanded = controller.expandedGroups[group.id] ?? true;
              bool isOptional = group.minModifiers == 0;
              bool isRequiredSelected = isOptional
                  ? controller.selectedModifiers[group.id]!.length >=
                      group.maxModifiers
                  : controller.selectedModifiers[group.id]!.length >=
                      group.minModifiers;

              String headerText;
              if (controller.selectedModifiers[group.id]!.isNotEmpty) {
                headerText = controller.getSelectedModifierAlias(group.id);
              } else {
                headerText = group.minModifiers == 1 && group.maxModifiers == 1
                    ? 'Seleccione 1'
                    : 'Seleccione hasta ${group.maxModifiers}';
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.toggleGroupExpansion(group.id);
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      group.alias,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      headerText,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: isRequiredSelected
                                      ? Colors.grey[300]
                                      : isOptional
                                          ? Colors.grey[300]
                                          : Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  isRequiredSelected
                                      ? 'Seleccionado'
                                      : isOptional
                                          ? 'Opcional'
                                          : 'Requerido',
                                  style: TextStyle(
                                      color: isRequiredSelected || isOptional
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isExpanded)
                        Column(
                          children: group.modifiers.map((modifier) {
                            bool isSelected = controller
                                .selectedModifiers[group.id]!
                                .contains(modifier.id);
                            bool isEnabled = isSelected ||
                                controller.selectedModifiers[group.id]!.length <
                                    group.maxModifiers;

                            if (group.maxModifiers == 1 &&
                                group.minModifiers == 1) {
                              return ModifierRadioWidget(
                                modifier: modifier,
                                groupValue: isSelected ? modifier.id : null,
                                onChanged: (value) {
                                  controller.toggleModifier(
                                      group.id, modifier.id,
                                      isRadio: true);
                                },
                              );
                            } else {
                              return ModifierCheckboxWidget(
                                modifier: modifier,
                                isSelected: isSelected,
                                isEnabled: isEnabled,
                                onChanged: (value) {
                                  controller.toggleModifier(
                                      group.id, modifier.id,
                                      isRadio: false);
                                },
                              );
                            }
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: TextField(
            onChanged: (value) {
              controller.notes.value = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Notas',
              hintText: 'Ingrese sus notas aquí',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const CustomDividerWidget(),
        const SizedBox(height: 20),
      ],
    );
  }
}


/*import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/models/order_product.dart';
import 'package:digital_menu_4urest/models/product_model.dart';
import 'package:digital_menu_4urest/providers/orders/product_controller.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:digital_menu_4urest/widgets/show_item_widgets/modifier_checkbox_widget.dart';
import 'package:digital_menu_4urest/widgets/show_item_widgets/modifier_radio_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductModifiersListWidget extends StatelessWidget {
  final BaseModelProduct product;
  final Function(bool, OrderProduct) onSelectionChanged;

  const ProductModifiersListWidget({
    super.key,
    required this.product,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    for (var group in product.modifiersGroups) {
      if (!controller.selectedModifiers.containsKey(group.id)) {
        controller.selectedModifiers[group.id] = <String>{};
      }
    }

    return Column(
      children: [
        ...product.modifiersGroups.map((group) {
          return GetBuilder<ProductController>(
            builder: (_) {
              bool isExpanded = controller.expandedGroups[group.id] ?? true;
              bool isOptional = group.minModifiers == 0;
              bool isRequiredSelected = isOptional
                  ? controller.selectedModifiers[group.id]!.length >=
                      group.maxModifiers
                  : controller.selectedModifiers[group.id]!.length >=
                      group.minModifiers;

              String headerText;
              if (controller.selectedModifiers[group.id]!.isNotEmpty) {
                headerText = controller.getSelectedModifierAlias(group.id);
              } else {
                headerText = group.minModifiers == 1 && group.maxModifiers == 1
                    ? 'Seleccione 1'
                    : 'Seleccione hasta ${group.maxModifiers}';
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.toggleGroupExpansion(group.id);
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    group.alias,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    headerText,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: isRequiredSelected
                                      ? Colors.grey[300]
                                      : isOptional
                                          ? Colors.grey[300]
                                          : Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  isRequiredSelected
                                      ? 'Seleccionado'
                                      : isOptional
                                          ? 'Opcional'
                                          : 'Requerido',
                                  style: TextStyle(
                                      color: isRequiredSelected || isOptional
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isExpanded)
                        Column(
                          children: group.modifiers.map((modifier) {
                            bool isSelected = controller
                                .selectedModifiers[group.id]!
                                .contains(modifier.id);
                            bool isEnabled = isSelected ||
                                controller.selectedModifiers[group.id]!.length <
                                    group.maxModifiers;

                            if (group.maxModifiers == 1 &&
                                group.minModifiers == 1) {
                              return ModifierRadioWidget(
                                modifier: modifier,
                                groupValue: isSelected ? modifier.id : null,
                                onChanged: (value) {
                                  controller.toggleModifier(
                                      group.id, modifier.id,
                                      isRadio: true);
                                },
                              );
                            } else {
                              return ModifierCheckboxWidget(
                                modifier: modifier,
                                isSelected: isSelected,
                                isEnabled: isEnabled,
                                onChanged: (value) {
                                  controller.toggleModifier(
                                      group.id, modifier.id,
                                      isRadio: false);
                                },
                              );
                            }
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: TextField(
            onChanged: (value) {
              controller.notes.value = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Notas',
              hintText: 'Ingrese sus notas aquí',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const CustomDividerWidget(),
        const SizedBox(height: 20),
      ],
    );
  }
}

*/

/* Respaldo con contraccion y expansion de los grupos de mod
class ProductModifiersListWidget extends StatelessWidget {
  final ProductModel product;
  final Function(bool, OrderProduct) onSelectionChanged;

  const ProductModifiersListWidget({
    super.key,
    required this.product,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    for (var group in product.modifiersGroups) {
      if (!controller.selectedModifiers.containsKey(group.id)) {
        controller.selectedModifiers[group.id] = <String>{};
      }
    }

    return Column(
      children: [
        ...product.modifiersGroups.map((group) {
          return GetBuilder<ProductController>(
            builder: (_) {
              bool isExpanded = controller.expandedGroups[group.id] ?? true;
              bool isOptional = int.parse(group.minModifiers) == 0;
              bool isRequiredSelected = isOptional
                  ? controller.selectedModifiers[group.id]!.length >=
                      int.parse(group.maxModifiers)
                  : controller.selectedModifiers[group.id]!.length >=
                      int.parse(group.minModifiers);

              String headerText;
              if (controller.selectedModifiers[group.id]!.isNotEmpty) {
                headerText = controller.getSelectedModifierAlias(group.id);
              } else {
                headerText = int.parse(group.minModifiers) == 1 &&
                        int.parse(group.maxModifiers) == 1
                    ? 'Seleccione 1'
                    : 'Seleccione hasta ${group.maxModifiers}';
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.toggleGroupExpansion(group.id);
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    group.alias,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    headerText,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: isRequiredSelected
                                      ? Colors.grey[300]
                                      : isOptional
                                          ? Colors.grey[300]
                                          : Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  isRequiredSelected
                                      ? 'Seleccionado'
                                      : isOptional
                                          ? 'Opcional'
                                          : 'Requerido',
                                  style: TextStyle(
                                      color: isRequiredSelected || isOptional
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 12),
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isExpanded)
                        Column(
                          children: group.modifiers.map((modifier) {
                            bool isSelected = controller
                                .selectedModifiers[group.id]!
                                .contains(modifier.id);
                            bool isEnabled = isSelected ||
                                controller.selectedModifiers[group.id]!.length <
                                    int.parse(group.maxModifiers);

                            if (int.parse(group.maxModifiers) == 1 &&
                                int.parse(group.minModifiers) == 1) {
                              return ModifierRadioWidget(
                                modifier: modifier,
                                groupValue: isSelected ? modifier.id : null,
                                onChanged: (value) {
                                  controller.toggleModifier(
                                      group.id, modifier.id,
                                      isRadio: true);
                                },
                              );
                            } else {
                              return ModifierCheckboxWidget(
                                modifier: modifier,
                                isSelected: isSelected,
                                isEnabled: isEnabled,
                                onChanged: (value) {
                                  controller.toggleModifier(
                                      group.id, modifier.id,
                                      isRadio: false);
                                },
                              );
                            }
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: TextField(
            onChanged: (value) {
              controller.notes.value = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Notas',
              hintText: 'Ingrese sus notas aquí',
            ),
          ),
        ),
        const SizedBox(height: 10),
        const CustomDividerWidget(),
        const SizedBox(height: 20),
      ],
    );
  }
}
 */