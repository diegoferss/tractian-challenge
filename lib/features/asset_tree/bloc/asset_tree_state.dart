import 'package:tractian/features/asset_tree/models/location.dart';
import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/enums/view_state_enum.dart';

class AssetTreeState {
  final UnitEnum unit;
  final ViewStateEnum viewState;
  final List<Location> locations;

  AssetTreeState({
    required this.unit,
    this.viewState = ViewStateEnum.initial,
    this.locations = const [],
  });

  AssetTreeState copyWith({
    UnitEnum? unit,
    ViewStateEnum? viewState,
    List<Location>? locations,
  }) {
    return AssetTreeState(
      unit: unit ?? this.unit,
      viewState: viewState ?? this.viewState,
      locations: locations ?? this.locations,
    );
  }
}
