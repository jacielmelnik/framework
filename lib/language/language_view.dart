import 'package:flutter/material.dart';
import 'package:framework/constants.dart';
import 'package:framework/language/language_view_model.dart';
import 'package:framework/shared/app_localizations.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.translate('english')),
            onTap: () {
              LanguageViewModel.changeToLanguage(AvailableLanguages.enUS);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.translate('portuguese')),
            onTap: () {
              LanguageViewModel.changeToLanguage(AvailableLanguages.ptBR);
            },
          )
        ],
      ),
    );
  }
}
