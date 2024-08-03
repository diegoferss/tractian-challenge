import 'package:flutter/material.dart';
import 'package:tractian/features/asset_tree/models/asset.dart';
import 'package:tractian/features/asset_tree/models/base_item.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';
import 'package:tractian/support/extensions/base_item_extensions.dart';

class ExpandableTile extends StatelessWidget {
  final BaseItem baseItem;
  final FilterOptionEnum? filterOption;
  final String search;

  const ExpandableTile({
    super.key,
    required this.baseItem,
    required this.search,
    this.filterOption,
  });

  @override
  Widget build(BuildContext context) {
    final subBaseItems = baseItem.subBaseItems.finalBaseItems(
      filterOption: filterOption,
      search: search,
    );

    if (subBaseItems.isEmpty) {
      return ListTile(
        leading: Image.asset(baseItem.icon),
        title: Text(
          baseItem.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (baseItem case Asset(:final sensorType) when sensorType == 'energy')
              const Icon(Icons.flash_on, size: 20, color: Colors.green),
            if (baseItem case Asset(:final status) when status == 'alert')
              const Icon(Icons.circle, size: 12, color: Colors.red),
          ],
        ),
      );
    }

    return ExpansionTile(
      shape: const Border(),
      childrenPadding: const EdgeInsets.only(left: 20),
      initiallyExpanded: true,
      leading: Image.asset(baseItem.icon),
      title: Text(
        baseItem.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      children: subBaseItems.map((subBaseItem) {
        return ExpandableTile(
          baseItem: subBaseItem,
          filterOption: filterOption,
          search: search,
        );
      }).toList(),
    );
  }
}
