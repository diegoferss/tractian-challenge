import 'package:flutter/material.dart';

enum UnitEnum {
  jaguar('Jaguar Unit', Icons.battery_charging_full),
  tobias('Tobias Unit', Icons.factory),
  apex('Apex Unit', Icons.settings);

  final String title;
  final IconData iconPath;

  const UnitEnum(this.title, this.iconPath);
}
