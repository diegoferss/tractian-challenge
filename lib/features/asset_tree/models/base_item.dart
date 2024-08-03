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
}
