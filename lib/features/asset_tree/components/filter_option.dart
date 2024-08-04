import 'package:flutter/material.dart';
import 'package:tractian/support/enums/filter_option_enum.dart';
import 'package:tractian/support/extensions/context_extensions.dart';
import 'package:tractian/support/styles/app_colors.dart';
import 'package:tractian/support/utils/localize.dart';

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
    final l10n = Localize.instance.l10n;
    final backgroundColor = isSelected ? AppColors.lightBlue : AppColors.backgroundColor;
    final itemsColor = isSelected ? AppColors.backgroundColor : AppColors.grey;
    final borderColor = isSelected ? AppColors.blue : AppColors.grey;
    final fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;

    return Chip(
      backgroundColor: backgroundColor,
      avatar: Icon(filterOption.icon, color: itemsColor),
      label: Text(
        filterOption.title(l10n),
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
