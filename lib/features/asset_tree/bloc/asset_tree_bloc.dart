import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_event.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_state.dart';
import 'package:tractian/features/asset_tree/use_cases/fetch_unit_locations.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/enums/view_state_enum.dart';

import '../use_cases/fetch_unit_assets.dart';

class AssetTreeBloc extends Bloc<AssetTreeEvent, AssetTreeState> {
  final FetchUnitAssets fetchUnitAssets;
  final FetchUnitLocations fetchUnitLocations;

  AssetTreeBloc({
    required UnitEnum unit,
    required this.fetchUnitAssets,
    required this.fetchUnitLocations,
  }) : super(AssetTreeState(unit: unit)) {
    on<AssetTreeLoadAssetsRequested>(_onLoadAssetsRequested);
  }

  FutureOr<void> _onLoadAssetsRequested(
    AssetTreeLoadAssetsRequested event,
    Emitter<AssetTreeState> emit,
  ) async {
    emit(state.copyWith(viewState: ViewStateEnum.loading));

    final result = await fetchUnitLocations(jsonPath: state.unit.locationsPath);

    result.fold(
      (locations) {
        emit(state.copyWith(locations: locations, viewState: ViewStateEnum.success));
      },
      (exception) {
        // TODO: Tratar o erro ao mapear os dados
      },
    );
  }
}
