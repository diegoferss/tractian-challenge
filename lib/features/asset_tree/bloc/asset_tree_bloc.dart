import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_event.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_state.dart';
import 'package:tractian/features/asset_tree/use_cases/fetch_unit_locations.dart';
import 'package:tractian/features/asset_tree/use_cases/unify_assets.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/enums/view_state_enum.dart';

import '../use_cases/fetch_unit_assets.dart';

class AssetTreeBloc extends Bloc<AssetTreeEvent, AssetTreeState> {
  final FetchUnitAssets fetchUnitAssets;
  final FetchUnitLocations fetchUnitLocations;
  final UnifyAssets unifyAssets;

  AssetTreeBloc({
    required UnitEnum unit,
    required this.fetchUnitAssets,
    required this.fetchUnitLocations,
    required this.unifyAssets,
  }) : super(AssetTreeState(unit: unit)) {
    on<AssetTreeLoadAssetsRequested>(_onLoadAssetsRequested);
  }

  FutureOr<void> _onLoadAssetsRequested(
    AssetTreeLoadAssetsRequested event,
    Emitter<AssetTreeState> emit,
  ) async {
    emit(state.copyWith(viewState: ViewStateEnum.loading));

    await _getLocations(emit);

    if (state.viewState == ViewStateEnum.error) return;

    await _getAssets(emit);

    if (state.viewState == ViewStateEnum.error) return;

    final result = unifyAssets(assets: (locations: state.locations, assets: state.assets));

    emit(state.copyWith(locations: result.locations, assets: result.assets));
  }

  FutureOr<void> _getLocations(Emitter<AssetTreeState> emit) async {
    final result = await fetchUnitLocations(jsonPath: state.unit.locationsPath);

    result.fold(
      (locations) {
        emit(state.copyWith(locations: locations));
      },
      (exception) {
        // TODO: Tratar o erro ao mapear os dados
        emit(state.copyWith(viewState: ViewStateEnum.error));
      },
    );
  }

  FutureOr<void> _getAssets(Emitter<AssetTreeState> emit) async {
    final result = await fetchUnitAssets(jsonPath: state.unit.assetsPath);

    result.fold(
      (assets) {
        emit(state.copyWith(assets: assets, viewState: ViewStateEnum.success));
      },
      (exception) {
        // TODO: Tratar o erro ao mapear os dados
        emit(state.copyWith(viewState: ViewStateEnum.error));
      },
    );
  }
}
