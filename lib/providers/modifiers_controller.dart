import 'package:get/get.dart';

class ModifiersController extends GetxController {
  //var selectedModifiers = {}.obs;
  var selectedModifiers = <String, Set<String>>{}.obs;

  void selectModifier(String groupId, String modifierId) {
    //selectedModifiers[groupId] = modifierId;
    selectedModifiers[groupId] = {modifierId};
    update();
  }

  String? getSelectedModifier(String groupId) {
    //return selectedModifiers[groupId];
    return selectedModifiers[groupId]?.first;
  }

  void toggleModifier(String groupId, String modifierId, int maxModifiers) {
    if (!selectedModifiers.containsKey(groupId)) {
      selectedModifiers[groupId] = <String>{};
    }

    if (selectedModifiers[groupId]!.contains(modifierId)) {
      selectedModifiers[groupId]!.remove(modifierId);
    } else {
      if (selectedModifiers[groupId]!.length < maxModifiers) {
        selectedModifiers[groupId]!.add(modifierId);
      }
    }
    update();
  }

/*
  void toggleModifier(
      String groupId, String modifierId, int minModifiers, int maxModifiers) {
    if (!selectedModifiers.containsKey(groupId)) {
      selectedModifiers[groupId] = <String>{};
    }

    if (selectedModifiers[groupId]!.contains(modifierId)) {
      selectedModifiers[groupId]!.remove(modifierId);
    } else {
      if (selectedModifiers[groupId]!.length < maxModifiers) {
        selectedModifiers[groupId]!.add(modifierId);
      }
    }
    update();
  }
*/
  bool isSelected(String groupId, String modifierId) {
    return selectedModifiers[groupId]?.contains(modifierId) ?? false;
  }

  int getSelectedCount(String groupId) {
    return selectedModifiers[groupId]?.length ?? 0;
  }
}


/*
  void toggleModifier(String groupId, String modifierId) {
    if (!selectedModifiers.containsKey(groupId)) {
      selectedModifiers[groupId] = <String>{};
    }

    if (selectedModifiers[groupId]!.contains(modifierId)) {
      selectedModifiers[groupId]!.remove(modifierId);
    } else {
      selectedModifiers[groupId]!.add(modifierId);
    }
    update();
  }*/