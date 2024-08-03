import 'package:tractian/features/asset_tree/models/base_item.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';

import '../../features/asset_tree/models/asset.dart';

extension BaseItemExtensions on List<BaseItem> {
  List<BaseItem> finalBaseItems({FilterOptionEnum? filterOption, String search = ''}) {
    final baseItems = filteredBaseItems(filterOption: filterOption);

    return baseItems.searchedBaseItems(search: search);
  }

  List<BaseItem> searchedBaseItems({String search = ''}) {
    if (search.isEmpty) return this;

    return where((baseItem) {
      return _hasSearchTerm(baseItem, search);
    }).toList();
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

    return baseItem.baseItems.any((c) {
      return _hasAsset(c, filter);
    });
  }

  bool _hasSearchTerm(BaseItem baseItems, String search) {
    final isSearchedBaseItem = baseItems.name.toLowerCase().contains(search.toLowerCase());

    if (isSearchedBaseItem) return true;
    if (!isSearchedBaseItem && baseItems.baseItems.isEmpty) return false;

    return baseItems.baseItems.any((c) {
      return _hasSearchTerm(c, search);
    });
  }
}
