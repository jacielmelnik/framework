import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/store/text_tag.dart';

void main() {
  late final Widget testWidget;
  const String textTagText = 'ecommerce';

  setUpAll(() async {
    await AppLocalizations.load();
    testWidget = const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: TextTag(textTagText),
      ),
    );
  });

  group('TextTag', () {
    testWidgets('Should show the text passed as parameter', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var text =
          find.text(AppLocalizations.translate(textTagText).toUpperCase());
      expectLater(text, findsOneWidget);
    });
  });
}
