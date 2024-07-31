import 'package:flutter/material.dart';

enum UnitEnum {
  jaguar(
    'Jaguar Unit',
    Icons.battery_charging_full,
    'data/jaguar_unit/assets.json',
    'data/jaguar_unit/locations.json',
  ),
  tobias(
    'Tobias Unit',
    Icons.factory,
    'data/tobias_unit/assets.json',
    'data/tobias_unit/locations.json',
  ),
  apex(
    'Apex Unit',
    Icons.settings,
    'data/apex_unit/assets.json',
    'data/apex_unit/locations.json',
  );

  final String title;
  final IconData iconPath;
  final String assetsPath;
  final String locationsPath;

  const UnitEnum(
    this.title,
    this.iconPath,
    this.assetsPath,
    this.locationsPath,
  );
}
