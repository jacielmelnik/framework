import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/cart/cart_view_model.dart';
import 'package:framework/confirmation/confirmation_view.dart';
import 'package:framework/shared/app_localizations.dart';
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
    return BlocBuilder<StoreItemMapBloc, StoreItemMapState>(
      builder: (blocContext, state) {
        if (state.map == null) {
          return const SizedBox.shrink();
        }
        return Column(
          verticalDirection: VerticalDirection.up,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ConfirmationView(storeItemMap: state.map!);
                    });
              },
              child: Text(
                AppLocalizations.translate('checkout').toUpperCase(),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              //Ensuring the map will not be null when entering the cart view
              itemCount: state.map == null
                  ? 0
                  : CartViewModel.selectedItemsCount(state.map!.values),
              itemBuilder: (context, index) {
                StoreItem _storeItem =
                    CartViewModel.selectedItemForIndex(state.map!, index);
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
                        Text(AppLocalizations.translate(_storeItem.name)),
                        Text('$_storeItemCount'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
