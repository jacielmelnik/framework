import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:framework/cart/cart_view_model.dart';
import 'package:framework/confirmation/confirmation_view.dart';
import 'package:framework/constants.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/store/blocs/store_events.dart';
import 'package:framework/store/blocs/store_item_map_bloc.dart';
import 'package:framework/store/blocs/store_item_map_state.dart';
import 'package:framework/store/store_item_model.dart';
import 'package:framework/store/text_tag.dart';

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
        return Container(
          height: Constants.kFixedBottonHeight /* 40 */ +
              Constants.kButtonHeight /* 40 */ +
              CartViewModel.selectedItemsCount(state.map!.values) *
                  (Constants.kCartItemsHeight + 4) /* 64 */ +
              98 /* Title and dragabble indicator */,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            color: Colors.white,
          ),
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              const SizedBox(height: 40),
              CartViewModel.selectedItemsCount(state.map!.values) == 0
                  ? const SizedBox()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.8, 40)),
                      onPressed: () {
                        //Showing the confirmation modal
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            final Map<String, int> _purchasedItemsMap =
                                CartViewModel.selectedStoreItems(state.map!);
                            return ConfirmationView(
                                storeItemMap: _purchasedItemsMap);
                          },
                        ).whenComplete(() {
                          //Cleaning the cart after finishing the checkout
                          blocContext
                              .read<StoreItemMapBloc>()
                              .add(const ResetAllCounters());

                          //Dismissing this modal
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        AppLocalizations.translate('checkout').toUpperCase(),
                      ),
                    ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: CartViewModel.selectedItemsCount(state.map!.values),
                itemBuilder: (context, index) {
                  StoreItem _storeItem =
                      CartViewModel.selectedItemForIndex(state.map!, index);
                  int _storeItemCount = state.map![_storeItem.name]!;

                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            blocContext.read<StoreItemMapBloc>().add(
                                ItemCounterReset(itemName: _storeItem.name));
                          },
                          icon: FontAwesomeIcons.trashCan,
                          backgroundColor: Colors.red.shade300,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: SizedBox(
                        height: Constants.kCartItemsHeight,
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Text(
                              AppLocalizations.translate(_storeItem.name),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            IconButton(
                              onPressed: () {
                                blocContext.read<StoreItemMapBloc>().add(
                                    ItemCounterDecrement(
                                        itemName: _storeItem.name));
                              },
                              icon: Icon(
                                FontAwesomeIcons.minus,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            TextTag(_storeItemCount.toString()),
                            IconButton(
                              onPressed: () {
                                blocContext.read<StoreItemMapBloc>().add(
                                    ItemCounterIncrement(
                                        itemName: _storeItem.name));
                              },
                              icon: Icon(
                                FontAwesomeIcons.plus,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              CartViewModel.selectedItemsCount(state.map!.values) == 0
                  ? Text(
                      AppLocalizations.translate('empty_cart'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize:
                              Theme.of(context).textTheme.titleLarge!.fontSize),
                    )
                  : Column(
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Text(
                          AppLocalizations.translate('my_cart'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        );
      },
    );
  }
}
