import 'package:tractian/features/asset_tree/bloc/asset_tree_bloc.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/services/service_locator/service_locator.dart';

import '../../../support/services/service_locator/app_module.dart';

class AssetTreeModule extends AppModule {
  static const String assetTreeRoute = '/asset-tree';

  @override
  void registerDependencies() {
    ServiceLocator.registerFactoryParam<AssetTreeBloc, UnitEnum>((unit) {
      return AssetTreeBloc(unit: unit);
    });
  }
}
