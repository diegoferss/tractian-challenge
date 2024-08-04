import 'dart:isolate';

import '../models/asset.dart';
import '../models/location.dart';

typedef UnifiedAssets = ({List<Location> locations, List<Asset> assets});

abstract class UnifyAssets {
  Future<UnifiedAssets> call({required UnifiedAssets assets});
}

class UnifyAssetsImpl extends UnifyAssets {
  @override
  Future<UnifiedAssets> call({required UnifiedAssets assets}) async {
    return await Isolate.run<UnifiedAssets>(() {
      final primaryLocations = <Location>[];
      final locationMaps = {for (final location in assets.locations) location.id: location};

      final primaryAssets = <Asset>[];
      final assetMaps = {for (final asset in assets.assets) asset.id: asset};

      for (final location in assets.locations) {
        final parentId = location.parentId;

        if (parentId == null) {
          primaryLocations.add(location);
        } else {
          locationMaps[parentId]?.subLocations.add(location);
        }
      }

      for (final asset in assets.assets) {
        final Asset(:parentId, :locationId) = asset;

        if (parentId == null && locationId == null) {
          primaryAssets.add(asset);
        } else if (parentId != null) {
          assetMaps[parentId]?.subAssets.add(asset);
        } else if (locationId != null) {
          locationMaps[locationId]?.subAssets.add(asset);
        }
      }

      return (locations: primaryLocations, assets: primaryAssets);
    });
  }
}
