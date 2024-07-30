import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class LocalizeProtocol {
  Localization get l10n;
  Localization of(BuildContext context);
}

class Localize extends LocalizeProtocol {
  Localization? _l10n;

  Localize._();

  static final LocalizeProtocol instance = Localize._();

  @override
  Localization get l10n => _l10n!;

  @override
  Localization of(BuildContext context) {
    _l10n = Localization.of(context);
    return l10n;
  }
}
