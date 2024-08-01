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
    final locations = maps.map((map) => fromMap(map)).toList();
    final primaryLocations = <Location>[];
    final locationMaps = {for (final location in locations) location.id: location};

    for (final location in locations) {
      final parentId = location.parentId;

      if (parentId == null) {
        primaryLocations.add(location);
      } else {
        locationMaps[parentId]?.subLocations.add(location);
      }
    }

    return primaryLocations;
  }
}
