import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:framework/constants.dart';
import 'package:framework/language/language_view_model.dart';
import 'package:framework/shared/app_localizations.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({Key? key, required this.currentLanguage})
      : super(key: key);

  final String currentLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.translate('language'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          ListTile(
            trailing: currentLanguage == AvailableLanguages.enUS.value
                ? const Icon(FontAwesomeIcons.check)
                : const SizedBox(),
            title: Text(AppLocalizations.translate('english')),
            onTap: () {
              if (currentLanguage != AvailableLanguages.enUS.value) {
                LanguageViewModel.changeToLanguage(
                    context, AvailableLanguages.enUS);
              }
            },
          ),
          ListTile(
            trailing: currentLanguage == AvailableLanguages.ptBR.value
                ? const Icon(FontAwesomeIcons.check)
                : const SizedBox(),
            title: Text(AppLocalizations.translate('portuguese')),
            onTap: () {
              if (currentLanguage != AvailableLanguages.ptBR.value) {
                LanguageViewModel.changeToLanguage(
                    context, AvailableLanguages.ptBR);
              }
            },
          )
        ],
      ),
    );
  }
}
