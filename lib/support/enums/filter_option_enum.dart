import 'package:flutter/material.dart';

enum FilterOptionEnum {
  energy,
  alert;

  String get filterName {
    return switch (this) {
      energy => 'Sensor de Energia',
      alert => 'Crítico',
    };
  }

  IconData get icon {
    return switch (this) {
      energy => Icons.flash_off,
      alert => Icons.dangerous,
    };
  }
}
