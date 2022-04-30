import 'package:flutter/material.dart';
import 'package:framework/login/login_view_model.dart';
import 'package:framework/shared/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool? _isPasswordVisible;
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.amber),
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [
            typingComponent(),
            Container(
              height: MediaQuery.of(context).size.height * 0.5 -
                  MediaQuery.of(context).viewPadding.top,
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.2,
                  0,
                  MediaQuery.of(context).size.width * 0.2,
                  0),
              //TODO: Add logo image
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  loginButtonClick() async {
    try {
      await LoginViewModel.login(context);
    } catch (e) {
      print('Error loginButtonClick: $e');
    }
  }

  typingComponent() {
    return Container(
      color: const Color(0x1A000000),
      height: MediaQuery.of(context).size.height * 0.5,
      child: AutofillGroup(
        child: Column(
          children: [
            Expanded(child: Container()),
            //EMAIL
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.translate('email').toUpperCase(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 12, bottom: 2),
                    decoration: const BoxDecoration(
                      color: Color(0x33000000),
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(12)),
                    ),
                    child: TextField(
                      autofillHints: const [AutofillHints.email],
                      textCapitalization: TextCapitalization.none,
                      controller: LoginViewModel.emailTextController(),
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
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.translate('password').toUpperCase(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 12, bottom: 2),
                    decoration: const BoxDecoration(
                      color: Color(0x33000000),
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(12)),
                    ),
                    child: TextField(
                      autofillHints: const [AutofillHints.password],
                      focusNode: _passwordFocusNode,
                      controller: LoginViewModel.passwordTextController(),
                      obscureText: !_isPasswordVisible!,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        suffixIcon: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible!,
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
                loginButtonClick();
              },
              child: Text(
                AppLocalizations.translate('login').toUpperCase(),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
