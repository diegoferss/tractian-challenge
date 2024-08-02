import 'package:flutter/material.dart';
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
        title: Text(component.name),
      );
    }

    return ExpansionTile(
      shape: const Border(),
      childrenPadding: const EdgeInsets.only(left: 20),
      initiallyExpanded: true,
      leading: Image.asset(component.icon),
      title: Text(component.name),
      children: component.subComponents.map((c) {
        return ExpandableTile(component: c);
      }).toList(),
    );
  }
}
