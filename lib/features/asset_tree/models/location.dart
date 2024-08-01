import 'asset.dart';

class Location {
  final String id;
  final String name;
  final String? parentId;
  final List<Location> subLocations = [];
  final List<Asset> assets = [];

  Location({
    required this.id,
    required this.name,
    this.parentId,
  });
}
