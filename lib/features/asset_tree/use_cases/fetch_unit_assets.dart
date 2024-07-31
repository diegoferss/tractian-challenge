import 'dart:async';

import 'package:tractian/support/services/service_locator/json_reader.dart';

abstract class FetchUnitAssets {
  FutureOr<void> call({required String jsonPath});
}

class FetchUnitAssetsImpl extends FetchUnitAssets {
  final JsonReader jsonReader;

  FetchUnitAssetsImpl({required this.jsonReader});

  @override
  FutureOr<void> call({required String jsonPath}) {
    try {
      final data = jsonReader.read(path: jsonPath);
      // TODO: Mapear os dados
    } on Error catch (_) {
      // TODO: Tratar o erro ao mapear os dados
    }
  }
}
