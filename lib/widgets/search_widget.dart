import 'dart:async';
import 'package:digital_menu_4urest/models/item_model.dart';
import 'package:digital_menu_4urest/models/metrics/search_event_metric.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatefulWidget {
  final Function(List<ItemModel>) onResultsFiltered;
  const SearchWidget({super.key, required this.onResultsFiltered});

  @override
  // ignore: library_private_types_in_public_api
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 52,
        child: Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color(0xffe3e3e6),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black),
                    onPressed: () {
                      GlobalConfigProvider.updateActiveScreen("HomeScreen");
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _controller,
                      style: const TextStyle(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: "Buscar Platillos o Bebidas",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _onSearchChanged(value),
                      //onChanged: (value) => _filterSearchResults(value),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 15,
                    color: Colors.black26,
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.magnifyingGlass,
                        color: Color(0xff88888a)),
                    onPressed: () => _filterSearchResults(_controller.text),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ]);
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      final searchEvent = SearchEventMetric(
        searchTerm: query,
      );
      if (query.length > 3 && !GlobalConfigProvider.develop) {
        GlobalConfigProvider.eventMetricProvider?.addMetric(searchEvent);
      }
      _filterSearchResults(query);
    });
  }

  void _filterSearchResults(String query) {
    query = removeDiacritics(query.toLowerCase());

    if (query.isEmpty) {
      widget.onResultsFiltered([]);
      return;
    }

    var catalog = GlobalConfigProvider.branchCatalog?.catalogs[0];
    if (catalog == null) {
      widget.onResultsFiltered([]);
      return;
    }

    var filteredItems = <ItemModel>[];
    for (var category in catalog.categories) {
      for (var item in category.products) {
        var itemAliasNormalized = removeDiacritics(item.alias.toLowerCase());
        var itemDescriptionNormalized =
            removeDiacritics(item.description.toLowerCase());

        if (itemAliasNormalized.contains(query) ||
            itemDescriptionNormalized.contains(query)) {
          filteredItems.add(item);
          continue;
        }

        for (var modGroup in item.modifiersGroups) {
          for (var modItem in modGroup.modifiers) {
            var modItemAliasNormalized =
                removeDiacritics(modItem.alias.toLowerCase());
            var modItemDescriptionNormalized =
                removeDiacritics(modItem.description.toLowerCase());

            if (modItemAliasNormalized.contains(query) ||
                modItemDescriptionNormalized.contains(query)) {
              filteredItems.add(item);
              break;
            }
          }
          if (filteredItems.contains(item)) {
            break;
          }
        }
      }
    }
    widget.onResultsFiltered(filteredItems);
  }

  String removeDiacritics(String str) {
    var withDia = 'ÁáÉéÍíÓóÚúÑñÜüÇç';
    var withoutDia = 'AaEeIiOoUuNnUuCc';
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }
}
