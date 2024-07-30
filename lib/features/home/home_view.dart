import 'package:flutter/material.dart';
import 'package:tractian/features/home/components/unit_button.dart';
import 'package:tractian/support/components/default_app_bar.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/utils/localize.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final l10n = Localize.instance.l10n;

    return Scaffold(
      appBar: DefaultAppBar(
        title: l10n.appTitle,
        toolbarHeight: 72,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
        itemCount: UnitEnum.values.length,
        itemBuilder: (_, index) {
          final unit = UnitEnum.values[index];

          return UnitButton(unit: unit, l10n: l10n);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 40),
      ),
    );
  }
}
