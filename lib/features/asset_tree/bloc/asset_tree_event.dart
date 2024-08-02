import 'package:tractian/support/enums/filter_option_enum.dart';

sealed class AssetTreeEvent {}

class AssetTreeLoadAssetsRequested extends AssetTreeEvent {}

class AssetTreeSearchRequested extends AssetTreeEvent {
  final String search;

  AssetTreeSearchRequested({required this.search});
}

class AssetTreeFilterOptionRequested extends AssetTreeEvent {
  final FilterOptionEnum filterOption;

  AssetTreeFilterOptionRequested({required this.filterOption});
}
