import 'package:framework/store/store_item_model.dart';

class StoreService {
  ///Returns the store items list
  static List<StoreItem> fetchStoreItemsList() {
    List<StoreItem> storeItemsList = [
      StoreItem(name: 'apple'),
      StoreItem(name: 'banana'),
      StoreItem(name: 'pear'),
      StoreItem(name: 'mango'),
      StoreItem(name: 'pineapple'),
    ];

    return storeItemsList;
  }
}
