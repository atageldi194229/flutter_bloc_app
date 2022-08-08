part of 'item_list_bloc.dart';

@immutable
class ItemListState<T> {
  final Iterable<T> list;
  const ItemListState(this.list);
}

@immutable
class ItemListInitial<T> extends ItemListState<T> {
  const ItemListInitial() : super(const []);
}
