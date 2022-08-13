extension AddWithoutDublicate<T> on List<T> {
  addWithoutDublicate(T item) {
    final found = any((element) => element == item);
    if (!found) add(item);
  }
}
