import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:tractian/features/adapters/asset_adapter.dart';
import 'package:tractian/features/asset_tree/models/asset.dart';
import 'package:tractian/support/services/service_locator/json_reader.dart';
import 'package:tractian/support/utils/typedefs.dart';

typedef AssetsResult = Output<List<Asset>>;

abstract class FetchUnitAssets {
  FutureOr<AssetsResult> call({required String jsonPath});
}

class FetchUnitAssetsImpl extends FetchUnitAssets {
  final JsonReader jsonReader;

  FetchUnitAssetsImpl({required this.jsonReader});

  @override
  FutureOr<AssetsResult> call({required String jsonPath}) async {
    try {
      final data = await jsonReader.read(path: jsonPath);
      final assets = AssetAdapter.fromMaps(data);

      return Left(assets);
    } on Exception catch (e) {
      // TODO: Tratar o erro ao mapear os dados
      return Right(e);
    }
  }
}
