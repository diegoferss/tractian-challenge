import 'package:tractian/features/asset_tree/models/asset.dart';

class AssetAdapter {
  AssetAdapter._();

  static Asset fromMap(Map map) {
    return Asset(
      id: map['id'],
      name: map['name'],
      locationId: map['locationId'],
      parentId: map['parentId'],
      sensorType: map['sensorType'],
      status: map['status'],
    );
  }

  static List<Asset> fromMaps(List<dynamic> maps) {
    return maps.map((map) => fromMap(map)).toList();
  }
}
