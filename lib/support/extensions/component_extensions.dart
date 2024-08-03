import 'package:tractian/features/asset_tree/models/component.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';

import '../../features/asset_tree/models/asset.dart';

extension ComponentExtensions on List<Component> {
  List<Component> finalComponents({FilterOptionEnum? filterOption, String search = ''}) {
    final components = filteredComponents(filterOption: filterOption);

    return components.searchedComponents(search: search);
  }

  List<Component> searchedComponents({String search = ''}) {
    if (search.isEmpty) return this;

    return where((component) {
      return _hasSearchTerm(component, search);
    }).toList();
  }

  List<Component> filteredComponents({FilterOptionEnum? filterOption}) {
    final localFilterOption = filterOption;

    if (localFilterOption == null) return this;

    return where((component) {
      return _hasAsset(component, localFilterOption);
    }).toList();
  }

  bool _hasAsset(Component component, FilterOptionEnum filter) {
    final isAsset = component is Asset;

    if (isAsset && (component.sensorType == filter.name || component.status == filter.name)) return true;
    if (isAsset && component.sensorType != filter.name && component.isSensorType) return false;

    return component.subComponents.any((c) {
      return _hasAsset(c, filter);
    });
  }

  bool _hasSearchTerm(Component component, String search) {
    final componentHasSearch = component.name.toLowerCase().contains(search.toLowerCase());

    if (componentHasSearch) return true;
    if (!componentHasSearch && component.subComponents.isEmpty) return false;

    return component.subComponents.any((c) {
      return _hasSearchTerm(c, search);
    });
  }
}
