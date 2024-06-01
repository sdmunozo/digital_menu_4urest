import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  late BaseModelProduct product;
  var quantity = 1.obs;
  var selectedModifiers = <String, Set<String>>{}.obs;
  var notes = ''.obs;
  var expandedGroups = <String, bool>{}.obs;

  void initialize(BaseModelProduct product) {
    this.product = product;
    clearSelections();
  }

  void incrementQuantity() {
    quantity.value++;
    GlobalConfigProvider.logMessage("quantity $quantity");
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      GlobalConfigProvider.logMessage("quantity $quantity");
    }
  }

  void toggleModifier(String groupId, String modifierId,
      {required bool isRadio}) {
    if (!selectedModifiers.containsKey(groupId)) {
      selectedModifiers[groupId] = <String>{};
    }
    if (isRadio) {
      selectedModifiers[groupId] = {modifierId};
    } else {
      if (selectedModifiers[groupId]!.contains(modifierId)) {
        selectedModifiers[groupId]!.remove(modifierId);
      } else {
        selectedModifiers[groupId]!.add(modifierId);
      }
    }

    bool isMaxSelected = selectedModifiers[groupId]!.length ==
        product.modifiersGroups
            .firstWhere((group) => group.id == groupId)
            .maxModifiers;
    update();

    if (isMaxSelected) {
      toggleGroupExpansion(groupId, collapse: true);
    }
    updateButtonState();
  }

  void toggleGroupExpansion(String groupId, {bool collapse = false}) {
    if (collapse) {
      expandedGroups[groupId] = false;
    } else {
      if (expandedGroups.containsKey(groupId)) {
        expandedGroups[groupId] = !expandedGroups[groupId]!;
      } else {
        expandedGroups[groupId] = true;
      }
    }
    update();
  }

  void clearSelections() {
    quantity.value = 1;
    selectedModifiers.clear();
    notes.value = '';
    expandedGroups.clear();
    updateButtonState();
  }

  String getSelectedModifierAlias(String groupId) {
    if (selectedModifiers[groupId]!.isEmpty) {
      return '';
    }
    final selectedModifierIds = selectedModifiers[groupId]!;
    final group =
        product.modifiersGroups.firstWhere((group) => group.id == groupId);
    final selectedModifiersAliases = group.modifiers
        .where((modifier) => selectedModifierIds.contains(modifier.id))
        .map((modifier) => modifier.alias)
        .toList();
    return selectedModifiersAliases.join(', ');
  }

  bool get areAllRequiredGroupsSelected {
    for (var group in product.modifiersGroups) {
      if (group.minModifiers > 0 &&
          selectedModifiers[group.id]!.length < group.minModifiers) {
        return false;
      }
    }
    return true;
  }

  void updateButtonState() {
    update(['addButton']);
  }
}



/* Respaldo con contraccion y expansion de los grupos de mod


class ProductController extends GetxController {
  late ProductModel product;
  var quantity = 1.obs;
  var selectedModifiers = <String, Set<String>>{}.obs;
  var notes = ''.obs;
  var expandedGroups = <String, bool>{}.obs;

  void initialize(ProductModel product) {
    this.product = product;
    clearSelections();
  }

  void incrementQuantity() {
    quantity.value++;
    GlobalConfigProvider.logMessage("quantity $quantity");
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      GlobalConfigProvider.logMessage("quantity $quantity");
    }
  }

  void toggleModifier(String groupId, String modifierId,
      {required bool isRadio}) {
    if (!selectedModifiers.containsKey(groupId)) {
      selectedModifiers[groupId] = <String>{};
    }
    if (isRadio) {
      selectedModifiers[groupId] = {modifierId};
    } else {
      if (selectedModifiers[groupId]!.contains(modifierId)) {
        selectedModifiers[groupId]!.remove(modifierId);
      } else {
        selectedModifiers[groupId]!.add(modifierId);
      }
    }

    bool isMaxSelected = selectedModifiers[groupId]!.length ==
        int.parse(product.modifiersGroups
            .firstWhere((group) => group.id == groupId)
            .maxModifiers);
    update();

    if (isMaxSelected) {
      toggleGroupExpansion(groupId, collapse: true);
    }
  }

  void toggleGroupExpansion(String groupId, {bool collapse = false}) {
    if (collapse) {
      expandedGroups[groupId] = false;
    } else {
      if (expandedGroups.containsKey(groupId)) {
        expandedGroups[groupId] = !expandedGroups[groupId]!;
      } else {
        expandedGroups[groupId] = true;
      }
    }
    update();
  }

  void clearSelections() {
    quantity.value = 1;
    selectedModifiers.clear();
    notes.value = '';
    expandedGroups.clear();
  }

  String getSelectedModifierAlias(String groupId) {
    if (selectedModifiers[groupId]!.isEmpty) {
      return '';
    }
    final selectedModifierIds = selectedModifiers[groupId]!;
    final group =
        product.modifiersGroups.firstWhere((group) => group.id == groupId);
    final selectedModifiersAliases = group.modifiers
        .where((modifier) => selectedModifierIds.contains(modifier.id))
        .map((modifier) => modifier.alias)
        .toList();
    return selectedModifiersAliases.join(', ');
  }
}

 */