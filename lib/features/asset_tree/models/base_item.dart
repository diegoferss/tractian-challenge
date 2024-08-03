abstract class BaseItem {
  final String id;
  final String name;
  final String? parentId;
  List<BaseItem> get baseItems;

  BaseItem({
    required this.id,
    required this.name,
    required this.parentId,
  });

  String get icon;
}
