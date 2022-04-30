import 'package:flutter/material.dart';
import 'package:framework/confirmation/confirmation_view_model.dart';
import 'package:framework/shared/app_localizations.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({Key? key, required this.storeItemMap})
      : super(key: key);

  final Map<String, int> storeItemMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        ElevatedButton(
          onPressed: () {
            ConfirmationViewModel.generateReceipt(storeItemMap);
          },
          child: Text(
            AppLocalizations.translate('generate_receipt').toUpperCase(),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: storeItemMap.length,
          itemBuilder: (BuildContext context, int index) {
            final MapEntry _storeItem = storeItemMap.entries.elementAt(index);
            return Text(
                '${AppLocalizations.translate(_storeItem.key)} _______ ${_storeItem.value}');
          },
        ),
      ],
    );
  }
}
