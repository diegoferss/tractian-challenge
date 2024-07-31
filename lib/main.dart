import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tractian/support/router/mobile_router.dart';
import 'package:tractian/support/styles/app_themes.dart';

import 'support/services/service_locator/service_locator.dart';
import 'support/utils/localize.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.theme,
      initialRoute: MobileRouter.initialRoute,
      routes: MobileRouter.routes,
      localizationsDelegates: Localization.localizationsDelegates,
      supportedLocales: Localization.supportedLocales,
      onGenerateTitle: (context) => Localize.instance.of(context).appTitle,
    );
  }
}
