import 'package:flutter/material.dart';
import 'package:framework/settings/settings_view_model.dart';
import 'package:framework/shared/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.translate('settings'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.translate('language')),
            onTap: () {
              SettingsViewModel.changeLanguage(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.translate('logout')),
            onTap: () {
              SettingsViewModel.logout(context);
            },
          )
        ],
      ),
    );
  }
}
