import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:framework/login/login_view_model.dart';
import 'package:framework/login/register_modal_view.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool? _isPasswordVisible = false;
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

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
                  Container(
                    color: const Color(0x1A000000),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: AutofillGroup(
                      child: Column(
                        children: [
                          Expanded(child: Container()),
                          //EMAIL
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 64,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    Text(
                                      AppLocalizations.translate('email')
                                          .toUpperCase(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.only(
                                      left: 12, bottom: 2),
                                  decoration: const BoxDecoration(
                                    color: Color(0x33000000),
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(12)),
                                  ),
                                  child: TextField(
                                    style: const TextStyle(color: Colors.white),
                                    autofillHints: const [AutofillHints.email],
                                    textCapitalization: TextCapitalization.none,
                                    controller:
                                        LoginViewModel.emailTextController(),
                                    obscureText: false,
                                    expands: false,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      suffixIcon: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          //PASSWORD
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 64,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    Text(
                                      AppLocalizations.translate('password')
                                          .toUpperCase(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.only(
                                      left: 12, bottom: 2),
                                  decoration: const BoxDecoration(
                                    color: Color(0x33000000),
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(12)),
                                  ),
                                  child: TextField(
                                    style: const TextStyle(color: Colors.white),
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    focusNode: _passwordFocusNode,
                                    controller:
                                        LoginViewModel.passwordTextController(),
                                    obscureText: !_isPasswordVisible!,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      suffixIcon: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        onTap: () => setState(
                                          () => _isPasswordVisible =
                                              !_isPasswordVisible!,
                                        ),
                                        child: Icon(
                                          _isPasswordVisible!
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          //LOGIN BUTTON
                          ElevatedButton(
                            onPressed: () {
                              LoginViewModel.login(context);
                            },
                            child: Text(
                              AppLocalizations.translate('login').toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    40)),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        isScrollControlled: true,
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
