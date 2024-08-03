import 'package:tractian/features/asset_tree/models/asset.dart';
import 'package:tractian/features/asset_tree/models/component.dart';
import 'package:tractian/features/asset_tree/models/location.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/enums/view_state_enum.dart';
import 'package:tractian/support/extensions/component_extensions.dart';

class AssetTreeState {
  final UnitEnum unit;
  final ViewStateEnum viewState;
  final List<Location> locations;
  final List<Asset> assets;
  final String search;
  final FilterOptionEnum? currentFilterOption;

  AssetTreeState({
    required this.unit,
    this.viewState = ViewStateEnum.initial,
    this.locations = const [],
    this.assets = const [],
    this.search = '',
    this.currentFilterOption,
  });

  AssetTreeState copyWith({
    UnitEnum? unit,
    ViewStateEnum? viewState,
    List<Location>? locations,
    List<Asset>? assets,
    String? search,
    FilterOptionEnum? currentFilterOption,
  }) {
    return AssetTreeState(
      unit: unit ?? this.unit,
      viewState: viewState ?? this.viewState,
      locations: locations ?? this.locations,
      assets: assets ?? this.assets,
      search: search ?? this.search,
      currentFilterOption: currentFilterOption ?? this.currentFilterOption,
    );
  }

  AssetTreeState removeFilterOption() {
    return AssetTreeState(
      unit: unit,
      viewState: viewState,
      locations: locations,
      assets: assets,
      search: search,
      currentFilterOption: null,
    );
  }

  bool isFilterOptionSelected(FilterOptionEnum filterOption) {
    return filterOption == currentFilterOption;
  }

  List<Component> get components {
    final mergedComponents = <Component>[...locations, ...assets];

    return mergedComponents.filteredComponents(filterOption: currentFilterOption);
  }
}
