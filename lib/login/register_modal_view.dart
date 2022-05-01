import 'package:flutter/material.dart';
import 'package:framework/constants.dart';
import 'package:framework/login/login_view_model.dart';
import 'package:framework/shared/app_localizations.dart';

class RegisterModalView extends StatefulWidget {
  const RegisterModalView({Key? key}) : super(key: key);

  @override
  State<RegisterModalView> createState() => _RegisterModalViewState();
}

class _RegisterModalViewState extends State<RegisterModalView> {
  bool _isPasswordVisible = false;
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.up,
          children: [
            const SizedBox(
              height: Constants.kFixedBottonHeight,
            ),
            //REGISTER BUTTON
            ElevatedButton(
              onPressed: () {
                LoginViewModel.register(context);
              },
              child: Text(
                AppLocalizations.translate('register').toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 40)),
            ),
            const SizedBox(height: 16),
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
                        AppLocalizations.translate('password').toUpperCase(),
                        style: const TextStyle(color: Colors.white),
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
                      style: const TextStyle(color: Colors.white),
                      autofillHints: const [AutofillHints.password],
                      focusNode: _passwordFocusNode,
                      controller: LoginViewModel.passwordTextController(),
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        suffixIcon: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible,
                          ),
                          child: Icon(
                            _isPasswordVisible
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
            const SizedBox(height: 16),
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
                        AppLocalizations.translate('email').toUpperCase(),
                        style: const TextStyle(color: Colors.white),
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
                      style: const TextStyle(color: Colors.white),
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
            const SizedBox(height: 16),
            Text(
              AppLocalizations.translate('register'),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
