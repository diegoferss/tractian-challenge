import 'package:tractian/features/asset_tree/models/base_item.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';

import '../../features/asset_tree/models/asset.dart';

extension BaseItemExtensions on List<BaseItem> {
  List<BaseItem> finalBaseItems({FilterOptionEnum? filterOption, String search = ''}) {
    final baseItems = filteredBaseItems(filterOption: filterOption);

    return baseItems.searchedBaseItems(search: search, filter: filterOption);
  }

  List<BaseItem> searchedBaseItems({String search = '', FilterOptionEnum? filter}) {
    if (search.isEmpty || isEmpty) return this;

    final searchedItems = where((baseItem) {
      return _hasSearchTerm(baseItem, search, filter);
    }).toList();

    if (searchedItems.isEmpty && first.hasParent) return this;

    return searchedItems;
  }

  bool _hasSearchTerm(BaseItem baseItem, String search, FilterOptionEnum? filter) {
    final isSearchedBaseItem = baseItem.name.toLowerCase().contains(search.toLowerCase());
    final hasAsset = filter == null || _hasAsset(baseItem, filter);

    if (isSearchedBaseItem && hasAsset) return true;

    return baseItem.subBaseItems.any((subBaseItem) {
      return _hasSearchTerm(subBaseItem, search, filter);
    });
  }

  List<BaseItem> filteredBaseItems({FilterOptionEnum? filterOption}) {
    final localFilterOption = filterOption;

    if (localFilterOption == null) return this;

    return where((baseItem) {
      return _hasAsset(baseItem, localFilterOption);
    }).toList();
  }

  bool _hasAsset(BaseItem baseItem, FilterOptionEnum filter) {
    final isAsset = baseItem is Asset;

    if (isAsset && (baseItem.sensorType == filter.name || baseItem.status == filter.name)) return true;
    if (isAsset && baseItem.sensorType != filter.name && baseItem.isSensorType) return false;

    return baseItem.subBaseItems.any((subBaseItem) {
      return _hasAsset(subBaseItem, filter);
    });
  }
}
