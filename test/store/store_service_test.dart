import 'package:flutter_test/flutter_test.dart';
import 'package:framework/store/store_item_model.dart';
import 'package:framework/store/store_service.dart';

void main() {
  group('Store Service', () {
    test('fetchStoreItemsList should return a list of StoreItems', () async {
      var _list = StoreService.fetchStoreItemsList();
      expect(_list, isA<List<StoreItem>>());
    });

    test(
        'fetchStoreItemsList should return "maçã, pêra, banana, abacaxi e manga" named StoreItems',
        () async {
      var _list = StoreService.fetchStoreItemsList();
      expect(
          null, isNot(_list.firstWhere((element) => element.name == 'maçã')));
      expect(
          null, isNot(_list.firstWhere((element) => element.name == 'pêra')));
      expect(
          null, isNot(_list.firstWhere((element) => element.name == 'banana')));
      expect(null,
          isNot(_list.firstWhere((element) => element.name == 'abacaxi')));
      expect(
          null, isNot(_list.firstWhere((element) => element.name == 'manga')));
    });
  });
}
