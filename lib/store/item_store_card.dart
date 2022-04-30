import 'package:flutter/material.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/store/text_tag.dart';

class ItemStoreCard extends StatelessWidget {
  const ItemStoreCard(
      {Key? key, required this.itemCount, required this.itemName})
      : super(key: key);

  final int itemCount;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      color: itemCount == 0
          ? Colors.white
          : Theme.of(context).primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                fit: BoxFit.fitHeight,
                image: AssetImage('images/$itemName.png'),
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              AppLocalizations.translate(itemName),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            (itemCount == 0) ? const TextTag('select') : const TextTag('added')
          ],
        ),
      ),
    );
  }
}
