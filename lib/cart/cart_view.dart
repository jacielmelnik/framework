import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/store/blocs/store_events.dart';
import 'package:framework/store/blocs/store_item_map_bloc.dart';
import 'package:framework/store/blocs/store_item_map_state.dart';
import 'package:framework/store/store_item_model.dart';
import 'package:framework/store/store_view_model.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreItemMapBloc, StoreItemMapState>(
          listener: (context, state) {
            setState(() {});
          },
          builder: (blocContext, state) {
            if (state.map == null) {
              return const SizedBox.shrink();
            }
            return ListView.builder(
              itemCount: state.map?.length,
              itemBuilder: (context, index) {
                StoreItem _storeItem = StoreViewModel.storeItemFromIndex(index);
                int _storeItemCount = state.map![_storeItem.name]!;

                return GestureDetector(
                  onTap: () {
                    blocContext
                        .read<StoreItemMapBloc>()
                        .add(ItemCounterDecrement(itemName: _storeItem.name));
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Text(_storeItem.name),
                        Text('$_storeItemCount'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
  }
}
