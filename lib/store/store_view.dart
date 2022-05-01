import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:framework/cart/cart_view.dart';
import 'package:framework/settings/settings_view.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/store/blocs/search_bloc.dart';
import 'package:framework/store/blocs/search_events.dart';
import 'package:framework/store/blocs/search_state.dart';
import 'package:framework/store/item_store_card.dart';
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
          leading: const SizedBox(),
          title: Text(
            AppLocalizations.translate('ecommerce'),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
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
          child: const Icon(
            FontAwesomeIcons.cartShopping,
            size: 18,
          ),
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              context: context,
              builder: (context) {
                return const CartView();
              },
            );
          },
        ),
        body: Column(
          children: [
            //Search component
            Container(
              height: 60,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    //Adds a bloc event when its text change
                    context
                        .read<SearchBloc>()
                        .add(OnChanged(searchText: value));
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.translate('search'),
                    floatingLabelStyle:
                        TextStyle(color: Theme.of(context).primaryColor),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    focusColor: Theme.of(context).primaryColor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              //Store Items ListView has two BlocBuilders:
              //
              //One for the SEARCH events
              //and another for the SELECTION events
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (searchBlocContext, searchState) {
                  return BlocBuilder<StoreItemMapBloc, StoreItemMapState>(
                    builder: (blocContext, state) {
                      if (state.map == null) {
                        return const SizedBox.shrink();
                      }
                      //Builds the StoreItemsCards
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.map?.length,
                        itemBuilder: (context, index) {
                          StoreItem _storeItem =
                              StoreViewModel.storeItemFromIndex(index);
                          int _storeItemCount = state.map![_storeItem.name]!;

                          //Filter searched items
                          if (searchState.searchText != "") {
                            //Using the item translation + lowercase
                            //as default for comparing the search
                            final String _translatedItemName =
                                AppLocalizations.translate(_storeItem.name)
                                    .toLowerCase();
                            final String _searchText =
                                searchState.searchText.toLowerCase();

                            if (!_translatedItemName.contains(_searchText)) {
                              //Return a SizedBox if the search do NOT match
                              return const SizedBox.shrink();
                            }
                          }

                          return GestureDetector(
                            onTap: () {
                              //Handles the item selection with bloc events
                              if (_storeItemCount == 0) {
                                blocContext.read<StoreItemMapBloc>().add(
                                    ItemCounterIncrement(
                                        itemName: _storeItem.name));
                              } else {
                                blocContext.read<StoreItemMapBloc>().add(
                                    ItemCounterDecrement(
                                        itemName: _storeItem.name));
                              }
                            },
                            child: ItemStoreCard(
                              itemCount: _storeItemCount,
                              itemName: _storeItem.name,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
