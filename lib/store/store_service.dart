import 'package:framework/store/store_item_model.dart';

class StoreService {
  ///Returns the store items list
  static List<StoreItem> fetchStoreItemsList() {
    List<StoreItem> storeItemsList = [
      StoreItem(name: 'item1', description: 'item 1 description'),
      StoreItem(name: 'item2', description: 'item 2 description'),
      StoreItem(name: 'item3', description: 'item 3 description'),
      StoreItem(name: 'item4', description: 'item 4 description'),
      StoreItem(name: 'item5', description: 'item 5 description'),
    ];

    return storeItemsList;
  }
}
