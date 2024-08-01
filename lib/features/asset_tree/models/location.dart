class Location {
  final String id;
  final String name;
  final String? parentId;
  final List<Location> subLocations = [];

  Location({
    required this.id,
    required this.name,
    this.parentId,
  });
}
