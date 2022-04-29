import 'package:framework/store/store_item_model.dart';
import 'package:framework/store/store_service.dart';

class StoreViewModel {
  late final List<StoreItem> _storeItemsList;

  ///Fetch store items list from service
  fetchStoreItemsList() {
    _storeItemsList = StoreService.fetchStoreItemsList();
  }
}
