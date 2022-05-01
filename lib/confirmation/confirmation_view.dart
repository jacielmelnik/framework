import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:framework/cart/cart_view_model.dart';
import 'package:framework/confirmation/confirmation_view_model.dart';
import 'package:framework/confirmation/receipt_viewer.dart';
import 'package:framework/constants.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/store/store_item_model.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({Key? key, required this.storeItemMap})
      : super(key: key);

  final Map<String, int> storeItemMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.kFixedBottonHeight /* 40 */ +
          Constants.kButtonHeight /* 40 */ +
          CartViewModel.selectedItemsCount(storeItemMap.values) *
              (Constants.kCartItemsHeight + 4) /* 64 */ +
          30 /* Product Quantity */ +
          106 /* Title and dragabble indicator */,
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
          const SizedBox(height: Constants.kFixedBottonHeight),
          ElevatedButton(
            onPressed: () async {
              PDFDocument? savedDocument =
                  await ConfirmationViewModel.generateReceipt(storeItemMap);
              if (savedDocument != null) {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return ReceiptViewer(document: savedDocument);
                    }).whenComplete(
                  () {
                    Navigator.pop(context);
                  },
                );
              }
            },
            child: Text(
              AppLocalizations.translate('generate_receipt').toUpperCase(),
            ),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 40)),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: CartViewModel.selectedItemsCount(storeItemMap.values),
            itemBuilder: (BuildContext context, int index) {
              StoreItem _storeItem =
                  CartViewModel.selectedItemForIndex(storeItemMap, index);
              int _storeItemCount = storeItemMap[_storeItem.name]!;

              return Container(
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
                      Text(
                        _storeItemCount.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 16)
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  AppLocalizations.translate('product'),
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Expanded(child: SizedBox(width: 16)),
                Text(
                  AppLocalizations.translate('quantity'),
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.translate('successful_purchase'),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black.withOpacity(0.25)),
          ),
        ],
      ),
    );
  }
}
