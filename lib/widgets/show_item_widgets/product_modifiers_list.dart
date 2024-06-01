import 'package:digital_menu_4urest/models/digital_menu/base_model_modifier.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_modifiers_group.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/models/order_product_model.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:digital_menu_4urest/widgets/show_item_widgets/modifier_checkbox_widget.dart';
import 'package:digital_menu_4urest/widgets/show_item_widgets/modifier_radio_widget.dart';
import 'package:flutter/material.dart';

class ProductModifiersList extends StatefulWidget {
  final BaseModelProduct product;
  final Function(bool, OrderProductModel) onSelectionChanged;

  const ProductModifiersList({
    super.key,
    required this.product,
    required this.onSelectionChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductModifiersListState createState() => _ProductModifiersListState();
}

class _ProductModifiersListState extends State<ProductModifiersList> {
  Map<String, Set<String>> selectedModifiers = {};
  Map<String, bool> expandedGroups = {};
  String notes = '';

  @override
  void initState() {
    super.initState();
    for (var group in widget.product.modifiersGroups) {
      selectedModifiers[group.id] = {};
      expandedGroups[group.id] = true;
    }
  }

  void checkSelection() {
    bool isValid = true;
    OrderProductModel orderSummary = OrderProductModel(
      productId: widget.product.id,
      productName: widget.product.alias,
      notes: notes,
      quantity: 1,
    );

    for (var group in widget.product.modifiersGroups) {
      if (selectedModifiers[group.id]!.length < group.minModifiers) {
        isValid = false;
      }
      List<BaseModelModifier> selectedGroupModifiers =
          selectedModifiers[group.id]!
              .map((modifierId) =>
                  group.modifiers.firstWhere((m) => m.id == modifierId))
              .toList();
      orderSummary.modifiersGroups.add(
        BaseModelModifiersGroup(
          id: group.id,
          alias: group.alias,
          description: group.description,
          image: group.image,
          status: group.status,
          sort: group.sort,
          minModifiers: group.minModifiers,
          maxModifiers: group.maxModifiers,
          modifiers: selectedGroupModifiers,
        ),
      );
    }

    orderSummary.calculateTotalAmount();
    widget.onSelectionChanged(isValid, orderSummary);
  }

  void onModifierChanged(String groupId, String? modifierId, bool isSelected) {
    setState(() {
      var group = widget.product.modifiersGroups
          .firstWhere((group) => group.id == groupId);

      if (modifierId != null) {
        if (isSelected) {
          if (selectedModifiers[groupId]!.length < group.maxModifiers) {
            selectedModifiers[groupId]!.add(modifierId);
          }
        } else {
          selectedModifiers[groupId]!.remove(modifierId);
        }
      }

      bool isRequiredSelected =
          selectedModifiers[groupId]!.length >= group.minModifiers;
      bool isMaxSelected =
          selectedModifiers[groupId]!.length >= group.maxModifiers;

      if (isRequiredSelected && !isMaxSelected) {
        expandedGroups[groupId] = true;
      } else if (isMaxSelected) {
        expandedGroups[groupId] = false;
      }

      checkSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.product.modifiersGroups.map((group) {
          bool isExpanded = expandedGroups[group.id] ?? false;

          bool isOptional = group.minModifiers == 0;
          bool isRequiredSelected = isOptional
              ? selectedModifiers[group.id]!.length >= group.maxModifiers
              : selectedModifiers[group.id]!.length >= group.minModifiers;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedGroups[group.id] = !isExpanded;
                      });
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
                                group.minModifiers == 1 &&
                                        group.maxModifiers == 1
                                    ? 'Seleccione 1'
                                    : 'Seleccione hasta ${group.maxModifiers}',
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
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isExpanded)
                    Column(
                      children: group.modifiers.map((modifier) {
                        bool isSelected =
                            selectedModifiers[group.id]!.contains(modifier.id);
                        bool isEnabled = isSelected ||
                            selectedModifiers[group.id]!.length <
                                group.maxModifiers;

                        if (group.maxModifiers == 1 &&
                            group.minModifiers == 1) {
                          return ModifierRadioWidget(
                            modifier: modifier,
                            groupValue: isSelected ? modifier.id : null,
                            onChanged: (value) {
                              onModifierChanged(group.id, value, value != null);
                            },
                          );
                        } else {
                          return ModifierCheckboxWidget(
                            modifier: modifier,
                            isSelected: isSelected,
                            isEnabled: isEnabled,
                            onChanged: (value) {
                              onModifierChanged(group.id, modifier.id, value!);
                            },
                          );
                        }
                      }).toList(),
                    ),
                ],
              ),
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: TextField(
            onChanged: (value) {
              setState(() {
                notes = value;
                checkSelection();
              });
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
