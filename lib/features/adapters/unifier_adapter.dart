// TODO: Remover desse arquivo e colocar no utils
import 'package:tractian/features/asset_tree/models/location.dart';

import '../asset_tree/models/asset.dart';

typedef UnifiedAssets = ({List<Location> locations, List<Asset> assets});

class UnifierAdapter {
  UnifierAdapter._();

  static UnifiedAssets unifyAssets({
    required List<Location> locations,
    required List<Asset> assets,
  }) {
    final primaryLocations = <Location>[];
    final locationMaps = {for (final location in locations) location.id: location};

    final primaryAssets = <Asset>[];
    final assetMaps = {for (final asset in assets) asset.id: asset};

    for (final location in locations) {
      final parentId = location.parentId;

      if (parentId == null) {
        primaryLocations.add(location);
      } else {
        locationMaps[parentId]?.subLocations.add(location);
      }
    }

    for (final asset in assets) {
      final Asset(:parentId, :locationId) = asset;

      if (parentId == null && locationId == null) {
        primaryAssets.add(asset);
      } else if (parentId != null) {
        assetMaps[parentId]?.subAssets.add(asset);
      } else if (locationId != null) {
        locationMaps[locationId]?.assets.add(asset);
      }
    }

    return (locations: primaryLocations, assets: primaryAssets);
  }
}
