

extension ListExtension<T> on List<T> {
  List<T> copy() {
    List<T> list = [];
    for (T el in this) {
      list.add(el);
    }

    return list;
  }

  List<T> duplicatedByX(int x) {

    List<T> finalList = [];

    for(int _ = x; _ >0; --_) {
      finalList.addAll(this);
    }

    return finalList;

  }
  bool compare(List<T> list2) {
    if (length != list2.length) {
      return false;
    }

    for (int i = 0; i < length; i++) {
      if (this[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }

  toJson() {
    List<Map> jsonList = [];

    for (dynamic item in this) {
      jsonList.add(item.toJson());
    }

    return jsonList;
  }

  removeAll(List<T> otherList) {
    for (T item in otherList) {
      remove(item);
    }
  }

  String getDisplay() {
    String displayText = "";

    for (T item in this) {
      displayText += item.toString();

      if (item != this.last) {
        displayText += ", ";
      }
    }

    return displayText;
  }

}
