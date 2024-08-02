import 'package:tractian/features/asset_tree/models/component.dart';
import 'package:tractian/support/styles/app_images.dart';

class Asset extends Component {
  final String? locationId;
  final String? sensorType;
  final String? status;
  final List<Asset> subAssets = [];

  Asset({
    required super.id,
    required super.name,
    this.locationId,
    super.parentId,
    this.sensorType,
    this.status,
  });

  @override
  List<Component> get subComponents => subAssets;

  @override
  String get icon => isSensorType ? AppImages.icComponent : AppImages.icAsset;

  bool get isSensorType => sensorType != null;
}
