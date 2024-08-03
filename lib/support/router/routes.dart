import 'package:tractian/features/asset_tree/di/asset_tree_module.dart';

enum Routes {
  assetTree(AssetTreeModule.assetTreeRoute);

  final String path;

  const Routes(this.path);
}
