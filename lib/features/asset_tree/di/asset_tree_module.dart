import 'package:tractian/features/asset_tree/asset_tree_view.dart';
import 'package:tractian/features/asset_tree/asset_tree_view_model.dart';
import 'package:tractian/features/asset_tree/use_cases/fetch_unit_assets.dart';
import 'package:tractian/features/asset_tree/use_cases/fetch_unit_locations.dart';
import 'package:tractian/features/asset_tree/use_cases/unify_assets.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/services/json_reader.dart';
import 'package:tractian/support/services/service_locator/service_locator.dart';

import '../../../support/services/service_locator/app_module.dart';

class AssetTreeModule extends AppModule {
  static const String assetTreeRoute = '/asset-tree';

  @override
  void registerDependencies() {
    ServiceLocator.registerFactory<FetchUnitAssets>(() {
      return FetchUnitAssetsImpl(jsonReader: ServiceLocator.get<JsonReader>());
    });

    ServiceLocator.registerFactory<FetchUnitLocations>(() {
      return FetchUnitLocationsImpl(jsonReader: ServiceLocator.get<JsonReader>());
    });

    ServiceLocator.registerFactory<UnifyAssets>(() {
      return UnifyAssetsImpl();
    });

    ServiceLocator.registerFactoryParam<AssetTreeViewModelProtocol, UnitEnum>((unit) {
      return AssetTreeViewModel(
        unit: unit,
        fetchUnitAssets: ServiceLocator.get<FetchUnitAssets>(),
        fetchUnitLocations: ServiceLocator.get<FetchUnitLocations>(),
        unifyAssets: ServiceLocator.get<UnifyAssets>(),
      );
    });
  }
}
