import 'dart:async';

import 'package:tractian/features/asset_tree/asset_tree_view.dart';
import 'package:tractian/features/asset_tree/models/asset.dart';
import 'package:tractian/features/asset_tree/models/location.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/enums/view_state_enum.dart';
import 'package:tractian/support/extensions/base_item_extensions.dart';
import 'package:tractian/support/extensions/list_extensions.dart';
import 'package:tractian/support/utils/debouncer.dart';

import '../../support/enums/filter_option_enum.dart';
import 'models/base_item.dart';
import 'use_cases/fetch_unit_assets.dart';
import 'use_cases/fetch_unit_locations.dart';
import 'use_cases/unify_assets.dart';

class AssetTreeViewModel extends AssetTreeViewModelProtocol {
  bool _isAssetPathExpanded = false;
  FilterOptionEnum? _filterOption;
  String _search = '';
  ViewStateEnum _viewState = ViewStateEnum.initial;

  final _locations = <Location>[];
  final _assets = <Asset>[];
  final _debouncer = Debouncer(duration: const Duration(seconds: 1));

  final UnitEnum unit;
  final FetchUnitAssets fetchUnitAssets;
  final FetchUnitLocations fetchUnitLocations;
  final UnifyAssets unifyAssets;

  AssetTreeViewModel({
    required this.unit,
    required this.fetchUnitAssets,
    required this.fetchUnitLocations,
    required this.unifyAssets,
  });

  @override
  FilterOptionEnum? get filterOption => _filterOption;

  @override
  bool get isAssetPathExpanded => _isAssetPathExpanded;

  @override
  String get search => _search;

  @override
  ViewStateEnum get viewState => _viewState;

  @override
  List<BaseItem> get baseItems {
    final mergedBaseItems = <BaseItem>[..._locations, ..._assets];

    return mergedBaseItems.finalBaseItems(
      filterOption: _filterOption,
      search: _search,
    );
  }

  @override
  void loadContent() {
    _initializeState();
  }

  @override
  void updateSearch(String search) {
    _viewState = ViewStateEnum.loading;

    _debouncer.run(action: () {
      _search = search;
      _isAssetPathExpanded = true;
      _viewState = ViewStateEnum.success;
      notifyListeners();
    });

    notifyListeners();
  }

  @override
  void updateFiterOption(FilterOptionEnum filterOption) {
    if (_filterOption == filterOption) {
      _filterOption = null;
    } else {
      _filterOption = filterOption;
    }

    _isAssetPathExpanded = true;
    notifyListeners();
  }

  @override
  bool isFilterOptionSelected(FilterOptionEnum filterOption) {
    return filterOption == _filterOption;
  }

  FutureOr<void> _initializeState() async {
    _viewState = ViewStateEnum.loading;
    notifyListeners();

    await _getLocations();

    if (_viewState.hasError) return;

    await _getAssets();

    if (_viewState.hasError) return;

    final result = await unifyAssets(assets: (locations: _locations, assets: _assets));

    _locations.updateList(newList: result.locations);
    _assets.updateList(newList: result.assets);

    _viewState = ViewStateEnum.success;

    notifyListeners();
  }

  FutureOr<void> _getLocations() async {
    final result = await fetchUnitLocations(jsonPath: unit.locationsPath);

    result.fold(
      (locations) => _locations.updateList(newList: locations),
      (exception) => _viewState = ViewStateEnum.error,
    );

    notifyListeners();
  }

  FutureOr<void> _getAssets() async {
    final result = await fetchUnitAssets(jsonPath: unit.assetsPath);

    result.fold(
      (assets) => _assets.updateList(newList: assets),
      (exception) => _viewState = ViewStateEnum.error,
    );

    notifyListeners();
  }
}
