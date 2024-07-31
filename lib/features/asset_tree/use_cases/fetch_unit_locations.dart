import 'dart:async';

import 'package:tractian/support/services/service_locator/json_reader.dart';

abstract class FetchUnitLocations {
  FutureOr<void> call({required String jsonPath});
}

class FetchUnitLocationsImpl extends FetchUnitLocations {
  final JsonReader jsonReader;

  FetchUnitLocationsImpl({required this.jsonReader});

  @override
  FutureOr<void> call({required String jsonPath}) {
    try {
      final data = jsonReader.read(path: jsonPath);
    } on Error catch (_) {
      // TODO: Tratar o erro ao mapear os dados
    }
  }
}
