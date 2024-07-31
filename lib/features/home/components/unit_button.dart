import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/extensions/context_extensions.dart';

import '../../../support/styles/app_colors.dart';

class UnitButton extends StatelessWidget {
  final UnitEnum unit;
  final Localization l10n;

  const UnitButton({
    super.key,
    required this.unit,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.push(page: Container(color: Colors.red));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 32),
        backgroundColor: AppColors.highlightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Icon(
            unit.iconPath,
            size: 32,
            color: AppColors.backgroundColor,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              unit.title,
              style: context.headlineSmall?.copyWith(color: AppColors.backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
