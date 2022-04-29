import 'package:framework/store/store_item_model.dart';

class StoreService {
  ///Returns the store items list
  static List<StoreItem> fetchStoreItemsList() {
    List<StoreItem> storeItemsList = [
      StoreItem(name: 'maçã'),
      StoreItem(name: 'banana'),
      StoreItem(name: 'pêra'),
      StoreItem(name: 'manga'),
      StoreItem(name: 'abacaxi'),
    ];

    return storeItemsList;
  }
}
