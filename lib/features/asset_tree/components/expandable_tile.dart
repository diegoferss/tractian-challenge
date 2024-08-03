import 'package:flutter/material.dart';
import 'package:tractian/features/asset_tree/models/asset.dart';
import 'package:tractian/features/asset_tree/models/component.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';
import 'package:tractian/support/extensions/component_extensions.dart';

class ExpandableTile extends StatelessWidget {
  final Component component;
  final FilterOptionEnum? filterOption;
  final String search;

  const ExpandableTile({
    super.key,
    required this.component,
    required this.search,
    this.filterOption,
  });

  @override
  Widget build(BuildContext context) {
    final subComponents = component.subComponents.finalComponents(
      filterOption: filterOption,
      search: search,
    );

    if (subComponents.isEmpty) {
      return ListTile(
        leading: Image.asset(component.icon),
        title: Text(
          component.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (component case Asset(:final sensorType) when sensorType == 'energy')
              const Icon(Icons.flash_on, size: 20, color: Colors.green),
            if (component case Asset(:final status) when status == 'alert')
              const Icon(Icons.circle, size: 12, color: Colors.red),
          ],
        ),
      );
    }

    return ExpansionTile(
      shape: const Border(),
      childrenPadding: const EdgeInsets.only(left: 20),
      initiallyExpanded: true,
      leading: Image.asset(component.icon),
      title: Text(
        component.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      children: subComponents.map((c) {
        return ExpandableTile(
          component: c,
          filterOption: filterOption,
          search: search,
        );
      }).toList(),
    );
  }
}
