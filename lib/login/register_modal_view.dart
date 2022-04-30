import 'package:flutter/material.dart';
import 'package:framework/login/login_interactive_widgets.dart';
import 'package:framework/login/login_view_model.dart';
import 'package:framework/shared/app_localizations.dart';

class RegisterModalView extends StatelessWidget {
  const RegisterModalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          LoginInteractiveWidget(
            buttonTitle: AppLocalizations.translate('register'),
            buttonCallback: () => {LoginViewModel.login(context)},
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.translate('register'),
            style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
