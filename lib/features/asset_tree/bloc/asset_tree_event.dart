sealed class AssetTreeEvent {}

class AssetTreeLoadAssetsRequested extends AssetTreeEvent {}

class AssetTreeSearchRequested extends AssetTreeEvent {
  final String search;

  AssetTreeSearchRequested({required this.search});
}
