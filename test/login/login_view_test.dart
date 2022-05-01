import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework/login/login_view.dart';
import 'package:framework/shared/app_localizations.dart';

void main() {
  late final Widget testWidget;

  setUpAll(() async {
    await AppLocalizations.load();
    testWidget = const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: LoginView(),
      ),
    );
  });

  group('LoginView', () {
    testWidgets('Should have an email field', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var email = find.text(AppLocalizations.translate('email').toUpperCase());
      expect(email, findsOneWidget);
    });

    testWidgets('Should have a password field', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var password =
          find.text(AppLocalizations.translate('password').toUpperCase());
      expect(password, findsOneWidget);
    });

    testWidgets('Should have two TextFields (email and password)',
        (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var textFields = find.byType(TextField);
      expect(textFields, findsNWidgets(2));
    });

    testWidgets('Should have a login button', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var login = find.text(AppLocalizations.translate('login').toUpperCase());
      expect(login, findsOneWidget);

      var loginButton = find.byType(ElevatedButton);
      expect(loginButton, findsOneWidget);
    });

    testWidgets('Should have a register button', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var registerLink =
          find.text(AppLocalizations.translate('new_user_question'));
      expect(registerLink, findsOneWidget);
    });

    testWidgets('Should open register view if tapped', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var newUser = find.text(AppLocalizations.translate('new_user_question'));
      expect(newUser, findsOneWidget);

      await tester.tap(newUser);
      await tester.pump();

      var registerTitle = find.text(AppLocalizations.translate('register'));
      expect(registerTitle, findsOneWidget);
    });
  });
}
