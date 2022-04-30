import 'package:flutter/material.dart';
import 'package:framework/shared/app_localizations.dart';

class TextTag extends StatelessWidget {
  const TextTag(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      height: 22,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 2, 12, 0),
        child: Text(
          AppLocalizations.translate(text).toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
