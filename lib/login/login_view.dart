import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework/login/login_interactive_widgets.dart';
import 'package:framework/login/login_view_model.dart';
import 'package:framework/login/register_modal_view.dart';
import 'package:framework/shared/app_localizations.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        var _androidAppRetain = const MethodChannel("android_app_retain");
        _androidAppRetain.invokeMethod("sendToBackground");
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  LoginInteractiveWidget(
                    buttonTitle: AppLocalizations.translate('login'),
                    buttonCallback: () => {LoginViewModel.login(context)},
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        context: context,
                        builder: (_) {
                          return const RegisterModalView();
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        0,
                        MediaQuery.of(context).size.width * 0.1,
                        MediaQuery.of(context).size.height * 0.08,
                      ),
                      child: Text(
                        AppLocalizations.translate('new_user_question'),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
