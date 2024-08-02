import 'package:flutter/material.dart';
import 'package:tractian/features/asset_tree/models/asset.dart';
import 'package:tractian/features/asset_tree/models/component.dart';

class ExpandableTile extends StatelessWidget {
  final Component component;

  const ExpandableTile({
    super.key,
    required this.component,
  });

  @override
  Widget build(BuildContext context) {
    if (component.subComponents.isEmpty) {
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
      children: component.subComponents.map((c) {
        return ExpandableTile(component: c);
      }).toList(),
    );
  }
}
