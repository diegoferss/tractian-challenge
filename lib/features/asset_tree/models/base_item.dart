import 'package:tractian/features/asset_tree/models/asset.dart';

import 'location.dart';

abstract class BaseItem {
  final String id;
  final String name;
  final String? parentId;
  List<BaseItem> get subBaseItems;

  BaseItem({
    required this.id,
    required this.name,
    required this.parentId,
  });

  String get icon;

  bool get hasParent {
    final item = this;

    return switch (item) {
      Asset(:final locationId) => parentId != null || locationId != null,
      Location(:final parentId) => parentId != null,
      _ => false,
    };
  }
}
