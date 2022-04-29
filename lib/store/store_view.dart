import 'package:flutter/material.dart';
import 'package:framework/store/store_item_model.dart';
import 'package:framework/store/store_service.dart';

class StoreView extends StatefulWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  late final List<StoreItem> _storeItemsList;

  @override
  void initState() {
    super.initState();
    _storeItemsList = StoreService.fetchStoreItemsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('teasd'),
        ),
        body: ListView.builder(
            itemCount: _storeItemsList.length,
            itemBuilder: (_, index) {
              return Card(
                child: Text(_storeItemsList[index].name),
              );
            }));
  }
}
