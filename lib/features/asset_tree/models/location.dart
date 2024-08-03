import 'package:tractian/features/asset_tree/models/base_item.dart';
import 'package:tractian/support/styles/app_images.dart';

import 'asset.dart';

class Location extends BaseItem {
  final List<Asset> subAssets = [];
  final List<Location> subLocations = [];

  Location({
    required super.id,
    required super.name,
    super.parentId,
  });

  @override
  List<BaseItem> get baseItems => [...subLocations, ...subAssets];

  @override
  String get icon => AppImages.icLocation;
}
