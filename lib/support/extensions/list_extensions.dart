extension ListExtensions<T> on List<T> {
  void updateList({required List<T> newList}) {
    clear();
    addAll(newList);
  }
}
