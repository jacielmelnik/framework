import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework/login/register_modal_view.dart';
import 'package:framework/shared/app_localizations.dart';

void main() {
  late final Widget testWidget;
  setUpAll(() async {
    await AppLocalizations.load();
    testWidget = const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: Scaffold(body: RegisterModalView()),
      ),
    );
  });

  group('RegisterModalView', () {
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

    testWidgets('Should have a register button', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var register =
          find.text(AppLocalizations.translate('register').toUpperCase());
      expect(register, findsOneWidget);

      var registerButton = find.byType(ElevatedButton);
      expect(registerButton, findsOneWidget);
    });
  });
}
