import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'support/utils/localize.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: Localization.localizationsDelegates,
      supportedLocales: Localization.supportedLocales,
      onGenerateTitle: (context) => Localize.instance.of(context).appTitle,
    );
  }
}
