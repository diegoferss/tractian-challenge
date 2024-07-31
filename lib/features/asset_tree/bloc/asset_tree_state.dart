import 'package:tractian/support/enums/unit_enum.dart';

class AssetTreeState {
  final UnitEnum unit;

  AssetTreeState({
    required this.unit,
  });

  AssetTreeState copyWith({UnitEnum? unit}) {
    return AssetTreeState(
      unit: unit ?? this.unit,
    );
  }
}
