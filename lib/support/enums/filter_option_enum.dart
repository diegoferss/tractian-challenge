import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FilterOptionEnum {
  energy,
  alert;

  String title(Localization l10n) {
    return switch (this) {
      energy => l10n.energySensor,
      alert => l10n.alertStatus,
    };
  }

  IconData get icon {
    return switch (this) {
      energy => Icons.flash_off,
      alert => Icons.dangerous,
    };
  }
}
