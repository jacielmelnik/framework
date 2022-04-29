import 'package:framework/store/store_item_model.dart';

class StoreService {
  ///Returns the store items list
  static List<StoreItem> fetchStoreItemsList() {
    List<StoreItem> storeItemsList = [
      StoreItem(name: 'maçã', description: 'item 1 description'),
      StoreItem(name: 'banana', description: 'item 2 description'),
      StoreItem(name: 'pêra', description: 'item 3 description'),
      StoreItem(name: 'manga', description: 'item 4 description'),
      StoreItem(name: 'abacaxi', description: 'item 5 description'),
    ];

    return storeItemsList;
  }
}
