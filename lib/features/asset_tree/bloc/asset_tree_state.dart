import 'package:tractian/support/enums/unit_enum.dart';
import 'package:tractian/support/enums/view_state_enum.dart';

class AssetTreeState {
  final UnitEnum unit;
  final ViewStateEnum viewState;

  AssetTreeState({
    required this.unit,
    this.viewState = ViewStateEnum.initial,
  });

  AssetTreeState copyWith({UnitEnum? unit, ViewStateEnum? viewState}) {
    return AssetTreeState(
      unit: unit ?? this.unit,
      viewState: viewState ?? this.viewState,
    );
  }
}
