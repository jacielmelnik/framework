import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:framework/shared/app_localizations.dart';
import 'package:framework/store/blocs/search_bloc.dart';
import 'package:framework/store/blocs/store_item_map_bloc.dart';
import 'package:framework/store/item_store_card.dart';
import 'package:framework/store/store_view.dart';

void main() {
  late final Widget testWidget;
  setUpAll(() async {
    await AppLocalizations.load();
    testWidget = MultiBlocProvider(
      providers: [
        BlocProvider<StoreItemMapBloc>(create: (_) => StoreItemMapBloc()),
        BlocProvider<SearchBloc>(create: (_) => SearchBloc())
      ],
      child: const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: StoreView(),
        ),
      ),
    );
  });

  group('StoreView', () {
    testWidgets('Should have a list of 5 StoreItems', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var itemStoreCard = find.byType(ItemStoreCard);
      expect(itemStoreCard, findsNWidgets(5));
    });

    testWidgets('Should have a search bar', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var search = find.text(AppLocalizations.translate('search'));
      expect(search, findsOneWidget);

      var searchTextField = find.byType(TextField);
      expect(searchTextField, findsOneWidget);
    });

    testWidgets('Should search when entering text to the search bar',
        (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var searchTextField = find.byType(TextField);
      expect(searchTextField, findsOneWidget);

      await tester.enterText(
          searchTextField, AppLocalizations.translate('banana'));
      await tester.pumpAndSettle();

      var itemStoreCard = find.byType(ItemStoreCard);
      expect(itemStoreCard, findsOneWidget);
    });

    testWidgets('Should have a cart floating button', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var floatingCartButton = find.byType(FloatingActionButton);
      expect(floatingCartButton, findsOneWidget);
    });

    testWidgets('Should show CartView when the cart floating button is tapped',
        (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var floatingCartButton = find.byType(FloatingActionButton);
      expect(floatingCartButton, findsOneWidget);

      await tester.tap(floatingCartButton);
      await tester.pumpAndSettle();

      var emptyCart = find.text(AppLocalizations.translate('empty_cart'));
      expect(emptyCart, findsOneWidget);
    });

    testWidgets('Should have a settings button', (tester) async {
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      var settingsButton = find.byIcon(Icons.settings);
      expect(settingsButton, findsOneWidget);
    });

    group('When tapping a StoreItemCard', () {
      testWidgets('Should select the item', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();

        var itemStoreCard = find.byType(ItemStoreCard);

        await tester.tap(itemStoreCard.first);
        await tester.pumpAndSettle();

        var search =
            find.text(AppLocalizations.translate('added').toUpperCase());
        expect(search, findsOneWidget);
      });

      testWidgets('Should deselect a previously selected item', (tester) async {
        await tester.pumpWidget(testWidget);
        await tester.pumpAndSettle();

        var itemStoreCard = find.byType(ItemStoreCard);

        await tester.tap(itemStoreCard.first);
        await tester.pumpAndSettle();

        await tester.tap(itemStoreCard.first);
        await tester.pumpAndSettle();

        var search = find
            .text(AppLocalizations.translate('added').toUpperCase()); //select
        expect(search, findsNothing);
      });

      group('When tapping the cart with a selected item', () {
        testWidgets('Should show the right title', (tester) async {
          await tester.pumpWidget(testWidget);
          await tester.pumpAndSettle();

          var itemStoreCard = find.byType(ItemStoreCard);

          await tester.tap(itemStoreCard.first);
          await tester.pumpAndSettle();

          var floatingCartButton = find.byType(FloatingActionButton);
          expect(floatingCartButton, findsOneWidget);

          await tester.tap(floatingCartButton);
          await tester.pumpAndSettle();

          var emptyCart = find.text(AppLocalizations.translate('empty_cart'));
          expect(emptyCart, findsNothing);

          var cart = find.text(AppLocalizations.translate('my_cart'));
          expect(cart, findsOneWidget);
        });

        testWidgets('Should show the selected item', (tester) async {
          await tester.pumpWidget(testWidget);
          await tester.pumpAndSettle();

          var itemStoreCard = find.byType(ItemStoreCard);

          await tester.tap(itemStoreCard.first);
          await tester.pumpAndSettle();

          var floatingCartButton = find.byType(FloatingActionButton);
          expect(floatingCartButton, findsOneWidget);

          await tester.tap(floatingCartButton);
          await tester.pumpAndSettle();

          var emptyCart = find.text(AppLocalizations.translate('apple'));
          //One inside the cart and the other in the background
          expect(emptyCart, findsNWidgets(2));
        });
      });
    });
  });
}
