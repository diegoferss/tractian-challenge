import 'package:flutter/material.dart';
import 'package:tractian/features/asset_tree/asset_tree_view.dart';
import 'package:tractian/features/home/home_view.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/extensions/context_extensions.dart';
import 'package:tractian/support/router/routes.dart';

class MobileRouter {
  static const String initialRoute = '/home';

  static final routes = <String, WidgetBuilder>{
    '/home': (_) => const HomeView(),
    Routes.assetTree.path: (context) {
      final unit = context.getRouteArgument<UnitEnum>();

      return AssetTreeView(unit: unit);
    },
  };
}
