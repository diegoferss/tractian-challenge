import 'package:tractian/features/asset_tree/models/component.dart';
import 'package:tractian/support/styles/app_images.dart';

import 'asset.dart';

class Location extends Component {
  final List<Asset> subAssets = [];
  final List<Location> subLocations = [];

  Location({
    required super.id,
    required super.name,
    super.parentId,
  });

  @override
  List<Component> get subComponents => [...subLocations, ...subAssets];

  @override
  String get icon => AppImages.icLocation;
}
