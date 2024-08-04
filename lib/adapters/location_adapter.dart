import 'dart:isolate';

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

  static Future<List<Location>> fromMaps(List<dynamic> maps) async {
    return await Isolate.run<List<Location>>(() {
      return maps.map((map) => fromMap(map)).toList();
    });
  }
}
