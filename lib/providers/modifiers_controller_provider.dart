// modifiers_controller_provider.dart

import 'package:digital_menu_4urest/models/digital_menu/base_model_modifier.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_modifiers_group.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/models/modifier_model.dart';
import 'package:digital_menu_4urest/models/modifiers_group_model.dart';
import 'package:digital_menu_4urest/models/order_product.dart';
import 'package:get/get.dart';

class ModifiersControllerProvider extends GetxController {
  var selectedModifiers = <String, Set<String>>{}.obs;
  var expandedGroups = <String, bool>{}.obs;
  var notes = ''.obs;
  late BaseModelProduct product;

  void initialize(BaseModelProduct product) {
    this.product = product;
    for (var group in product.modifiersGroups) {
      selectedModifiers[group.id] = <String>{};
      expandedGroups[group.id] = true;
    }
  }

  void checkSelection(Function(bool, OrderProduct) onSelectionChanged) {
    bool isValid = true;
    OrderProduct orderSummary = OrderProduct(
      product: product,
      notes: notes.value,
      quantity: 1,
    );

    for (var group in product.modifiersGroups) {
      if (selectedModifiers[group.id]!.length < group.minModifiers) {
        isValid = false;
      }
      List<BaseModelModifier> selectedGroupModifiers =
          selectedModifiers[group.id]!.map((modifierId) {
        return group.modifiers.firstWhere((m) => m.id == modifierId);
      }).toList();
      orderSummary.product.modifiersGroups.add(
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
    onSelectionChanged(isValid, orderSummary);
  }

  void onModifierChanged(String groupId, String? modifierId, bool isSelected,
      Function(bool, OrderProduct) onSelectionChanged) {
    var group =
        product.modifiersGroups.firstWhere((group) => group.id == groupId);

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

    if (isRequiredSelected || isMaxSelected) {
      checkSelection(onSelectionChanged);
    }
  }
}
