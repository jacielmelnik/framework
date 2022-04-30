import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/cart/cart_view.dart';
import 'package:framework/settings/settings_view.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/store/blocs/store_events.dart';
import 'package:framework/store/blocs/store_item_map_bloc.dart';
import 'package:framework/store/blocs/store_item_map_state.dart';
import 'package:framework/store/store_item_model.dart';
import 'package:framework/store/store_view_model.dart';

class StoreView extends StatefulWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  @override
  void initState() {
    super.initState();

    final Map<String, int> _cleanMap = StoreViewModel.resetStoreItemMap();
    context.read<StoreItemMapBloc>().add(ListInitialized(map: _cleanMap));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        var _androidAppRetain = const MethodChannel("android_app_retain");
        _androidAppRetain.invokeMethod("sendToBackground");
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blocs'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const SettingsView();
                  }));
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return const CartView();
              },
            );
          },
        ),
        body: BlocConsumer<StoreItemMapBloc, StoreItemMapState>(
          listener: (context, state) {
            setState(() {});
          },
          builder: (blocContext, state) {
            if (state.map == null) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.map?.length,
              itemBuilder: (context, index) {
                StoreItem _storeItem = StoreViewModel.storeItemFromIndex(index);
                int _storeItemCount = state.map![_storeItem.name]!;

                return GestureDetector(
                  onTap: () {
                    blocContext
                        .read<StoreItemMapBloc>()
                        .add(ItemCounterIncrement(itemName: _storeItem.name));
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Text(AppLocalizations.translate(_storeItem.name)),
                        Text('$_storeItemCount'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
