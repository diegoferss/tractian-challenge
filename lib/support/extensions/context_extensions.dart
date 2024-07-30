import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Color get primaryColor {
    return Theme.of(this).colorScheme.primary;
  }

  Color get onPrimaryColor {
    return Theme.of(this).colorScheme.onPrimary;
  }

  TextStyle? get headlineLarge {
    return Theme.of(this).textTheme.headlineLarge;
  }

  TextStyle? get headlineMedium {
    return Theme.of(this).textTheme.headlineMedium;
  }

  TextStyle? get headlineSmall {
    return Theme.of(this).textTheme.headlineSmall;
  }

  TextStyle? get titleLarge {
    return Theme.of(this).textTheme.titleLarge;
  }

  TextStyle? get titleMedium {
    return Theme.of(this).textTheme.titleMedium;
  }

  TextStyle? get titleSmall {
    return Theme.of(this).textTheme.titleSmall;
  }

  TextStyle? get bodyLarge {
    return Theme.of(this).textTheme.bodyLarge;
  }

  TextStyle? get bodyMedium {
    return Theme.of(this).textTheme.bodyMedium;
  }

  TextStyle? get bodySmall {
    return Theme.of(this).textTheme.bodySmall;
  }
}
