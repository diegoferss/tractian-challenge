import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum UnitEnum {
  jaguar(
    Icons.battery_charging_full,
    'data/jaguar_unit/assets.json',
    'data/jaguar_unit/locations.json',
  ),
  tobias(
    Icons.factory,
    'data/tobias_unit/assets.json',
    'data/tobias_unit/locations.json',
  ),
  apex(
    Icons.settings,
    'data/apex_unit/assets.json',
    'data/apex_unit/locations.json',
  );

  final IconData iconPath;
  final String assetsPath;
  final String locationsPath;

  const UnitEnum(
    this.iconPath,
    this.assetsPath,
    this.locationsPath,
  );

  String title(Localization l10n) {
    return switch (this) {
      jaguar => l10n.jaguarUnit,
      tobias => l10n.tobiasUnit,
      apex => l10n.apexUnit,
    };
  }
}
