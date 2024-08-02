import 'package:flutter/material.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';
import 'package:tractian/support/extensions/context_extensions.dart';

class FilterOption extends StatelessWidget {
  final FilterOptionEnum filterOption;
  final bool isSelected;

  const FilterOption({
    super.key,
    required this.filterOption,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected ? Colors.lightBlue : Colors.white;
    final itemsColor = isSelected ? Colors.white : Colors.grey;
    final borderColor = isSelected ? Colors.blue : Colors.grey;
    final fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;

    return Chip(
      backgroundColor: backgroundColor,
      avatar: Icon(filterOption.icon, color: itemsColor),
      label: Text(
        filterOption.filterName,
        style: context.titleMedium?.copyWith(
          color: itemsColor,
          fontWeight: fontWeight,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );
  }
}
