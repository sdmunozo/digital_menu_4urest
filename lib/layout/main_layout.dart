import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double maxHeight = constraints.maxHeight;
              double maxWidth = constraints.maxWidth;

              double desiredHeight = 932;
              double desiredWidth = 430;

              return SizedBox(
                height: maxHeight > desiredHeight ? desiredHeight : maxHeight,
                width: maxWidth > desiredWidth ? desiredWidth : maxWidth,
                child: Container(
                    padding: const EdgeInsets.only(top: 100, bottom: 40),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: CustomImageProvider.getNetworkImageIP(
                            GlobalConfigProvider.branchCatalog?.menuBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: child),
              );
            },
          ),
        ),
      ),
    );
  }
}


/*import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
    required this.branchCatalogModel,
    required this.child,
  });

  final BranchCatalogModel branchCatalogModel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double maxHeight = constraints.maxHeight;
              double maxWidth = constraints.maxWidth;

              double desiredHeight = 932;
              double desiredWidth = 430;

              return SizedBox(
                height: maxHeight > desiredHeight ? desiredHeight : maxHeight,
                width: maxWidth > desiredWidth ? desiredWidth : maxWidth,
                child: Container(
                    padding: const EdgeInsets.only(top: 100, bottom: 40),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(branchCatalogModel.menuBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: child),
              );
            },
          ),
        ),
      ),
    );
  }
}
*/

/*

 */