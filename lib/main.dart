import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:framework/constants.dart';
import 'package:framework/init/init_view.dart';
import 'package:framework/login/login_view.dart';
import 'package:framework/store/blocs/search_bloc.dart';
import 'package:framework/store/blocs/store_item_map_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final appSupportedLocales = <Locale>[
    const Locale('pt'),
    const Locale('en'),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoreItemMapBloc>(create: (_) => StoreItemMapBloc()),
        BlocProvider<SearchBloc>(create: (_) => SearchBloc())
      ],
      child: MaterialApp(
          title: 'Framework',
          supportedLocales: appSupportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF048A81),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold)),
            ),
            textTheme: GoogleFonts.latoTextTheme(
              Theme.of(context).textTheme,
            ),
            fontFamily: GoogleFonts.lato().fontFamily,
            primaryColor: const Color(0xFF5F3473),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF5F3473),
              centerTitle: false,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF048A81),
            ),
            cardTheme: const CardTheme(elevation: 0),
          ),
          routes: {
            '/': (_) => const InitView(),
            Constants.loginRouteName: (_) => LoginView()
          }),
    );
  }
}
