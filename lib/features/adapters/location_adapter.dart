import 'package:tractian/features/asset_tree/models/location.dart';

class LocationAdapter {
  LocationAdapter._();

  static Location fromMap(Map map) {
    return Location(
      id: map['id'],
      name: map['name'],
      parentId: map['parentId'],
    );
  }

  static List<Location> fromMaps(List<dynamic> maps) {
    return maps.map((map) => fromMap(map)).toList();
  }
}
