abstract class Component {
  final String id;
  final String name;
  final String? parentId;
  List<Component> get subComponents;

  Component({
    required this.id,
    required this.name,
    required this.parentId,
  });

  String get icon;
}
