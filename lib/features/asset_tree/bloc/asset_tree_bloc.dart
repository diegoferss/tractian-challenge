import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_event.dart';
import 'package:tractian/features/asset_tree/bloc/asset_tree_state.dart';
import 'package:tractian/support/enums/unit_enum.dart';

class AssetTreeBloc extends Bloc<AssetTreeEvent, AssetTreeState> {
  AssetTreeBloc({
    required UnitEnum unit,
  }) : super(AssetTreeState(unit: unit));
}
