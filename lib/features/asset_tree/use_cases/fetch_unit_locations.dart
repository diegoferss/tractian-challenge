import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:tractian/adapters/location_adapter.dart';
import 'package:tractian/support/services/json_reader.dart';
import 'package:tractian/support/utils/typedefs.dart';

import '../models/location.dart';

typedef LocationsResult = Output<List<Location>>;

abstract class FetchUnitLocations {
  FutureOr<LocationsResult> call({required String jsonPath});
}

class FetchUnitLocationsImpl extends FetchUnitLocations {
  final JsonReader jsonReader;

  FetchUnitLocationsImpl({required this.jsonReader});

  @override
  FutureOr<LocationsResult> call({required String jsonPath}) async {
    try {
      final data = await jsonReader.read(path: jsonPath);
      final locations = await LocationAdapter.fromMaps(data);

      return Left(locations);
    } on Exception catch (e) {
      return Right(e);
    }
  }
}
