import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:framework/login/login_interactive_widgets.dart';
import 'package:framework/login/login_view_model.dart';
import 'package:framework/login/register_modal_view.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black.withOpacity(0.25)),
                      child: const Icon(
                        FontAwesomeIcons.cartShopping,
                        color: Colors.white,
                        size: 72,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DESAFIO',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          'E-COMMERCE',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
