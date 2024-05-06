import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/models/item_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/no_results_found_widget.dart';
import 'package:digital_menu_4urest/widgets/initial_search_widget.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:digital_menu_4urest/widgets/section_horizontal_item.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<ItemModel> _filteredResults = [];
  bool _searchStarted = false;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Container(
        color: GlobalConfigProvider.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: SearchWidget(
                onResultsFiltered: (results) {
                  setState(() {
                    _filteredResults = results;
                    _searchStarted = true;
                  });
                },
              ),
            ),
            Expanded(
              child: _searchStarted
                  ? (_filteredResults.isEmpty
                      ? const NoResultsFoundWidget()
                      : ListView.builder(
                          itemCount: _filteredResults.length,
                          itemBuilder: (context, index) {
                            return SectionHorizontalItem(
                                item: _filteredResults[index]);
                          },
                        ))
                  : const InitialSearchWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<ItemModel> _filteredResults = [];
  bool _searchStarted =
      false; // Nuevo estado para rastrear si la búsqueda ha comenzado

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Container(
        color: GlobalConfigProvider.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: SearchWidget(
                onResultsFiltered: (results) {
                  setState(() {
                    _filteredResults = results;
                    _searchStarted =
                        true; // Actualiza que la búsqueda ha comenzado
                  });
                },
              ),
            ),
            Expanded(
              child: !_searchStarted
                  ? const InitialSearchWidget() // Muestra este widget si no se ha comenzado a buscar
                  : _filteredResults.isEmpty
                      ? const NoResultsFoundWidget() // Muestra no resultados si la lista está vacía
                      : ListView.builder(
                          itemCount: _filteredResults.length,
                          itemBuilder: (context, index) {
                            return SectionHorizontalItem(
                                item: _filteredResults[index]);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
*/