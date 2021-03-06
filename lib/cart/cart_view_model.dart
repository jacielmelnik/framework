import 'package:framework/store/store_item_model.dart';

class CartViewModel {
  static int selectedItemsCount(Iterable<int> listItems) {
    int _count = 0;
    for (var item in listItems) {
      if (item > 0) {
        _count++;
      }
    }
    return _count;
  }

  static StoreItem selectedItemForIndex(Map<String, int> map, int index) {
    //Can definitelly improve this method
    int _ignores = index;
    for (var entries in map.entries) {
      if (entries.value > 0) {
        if (_ignores > 0) {
          _ignores--;
        } else {
          return StoreItem(name: entries.key);
        }
      }
    }
    return StoreItem(name: 'void');
  }

  static Map<String, int> selectedStoreItems(Map<String, int> map) {
    final Map<String, int> selectedItems = {};

    for (var item in map.entries) {
      if (item.value > 0) {
        selectedItems[item.key] = item.value;
      }
    }
    return selectedItems;
  }
}
