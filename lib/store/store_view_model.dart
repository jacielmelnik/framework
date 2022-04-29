import 'package:framework/store/store_item_model.dart';
import 'package:framework/store/store_service.dart';

class StoreViewModel {
  static StoreItem storeItemFromIndex(int index) {
    final List<StoreItem> _listItems = StoreService.fetchStoreItemsList();
    return _listItems[index];
  }

  static Map<String, int> resetStoreItemMap() {
    final List<StoreItem> _listItems = StoreService.fetchStoreItemsList();
    final Map<String, int> _map = {};

    for (final StoreItem item in _listItems) {
      _map[item.name] = 0;
    }

    return _map;
  }
}
