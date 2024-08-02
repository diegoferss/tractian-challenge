import 'package:flutter/material.dart';

enum FilterOptionEnum {
  energySensor,
  critical;

  String get filterName {
    return switch (this) {
      energySensor => 'Sensor de Energia',
      critical => 'Crítico',
    };
  }

  IconData get icon {
    return switch (this) {
      energySensor => Icons.flash_off,
      critical => Icons.dangerous,
    };
  }
}
