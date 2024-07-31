import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_event.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_state.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/services/service_locator/json_reader.dart';

class AssetTreeBloc extends Bloc<AssetTreeEvent, AssetTreeState> {
  final JsonReader jsonReader;

  AssetTreeBloc({
    required UnitEnum unit,
    required this.jsonReader,
  }) : super(AssetTreeState(unit: unit)) {
    on<AssetTreeLoadAssetsRequested>(_onLoadAssetsRequested);
  }

  FutureOr<void> _onLoadAssetsRequested(
    AssetTreeLoadAssetsRequested event,
    Emitter<AssetTreeState> emit,
  ) {}
}
