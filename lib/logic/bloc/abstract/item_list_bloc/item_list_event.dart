part of 'item_list_bloc.dart';

@immutable
class ItemListEvent<T> {
  const ItemListEvent();
}

@immutable
class LoadItemListEvent<T> extends ItemListEvent<T> {
  final Future<Iterable<T>> Function() loader;
  const LoadItemListEvent({
    required this.loader,
  });
}
