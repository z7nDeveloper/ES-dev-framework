import 'package:flutter/cupertino.dart';

class ListValueNotifier<T> extends ValueNotifier<List<T>> {
  List<Function(T)> onAdd = [];
  List<Function(T)> onRemove = [];

  ListValueNotifier(super.value);

  get isEmpty => value == null || value.isEmpty;

  get length => value.length;

  T get first => value.first;

  add(T valueToAdd) {
    value.add(valueToAdd);
    notifyListeners();
  }

  remove(T valueToAdd) {
    value.remove(valueToAdd);
    notifyListeners();
  }

  clear() {
    value.clear();
    notifyListeners();
  }

  map<S>(S Function(T item) mapper) {
    return value.map(mapper);
  }

  bool contains(item) {
    return value.contains(item);
  }
}
