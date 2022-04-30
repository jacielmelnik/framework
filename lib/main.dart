import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:framework/init/init_view.dart';
import 'package:framework/login/login_view.dart';
import 'package:framework/settings/settings_view.dart';
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
        BlocProvider<StoreItemMapBloc>(create: (_) => StoreItemMapBloc())
      ],
      child: MaterialApp(
          title: 'Framework',
          supportedLocales: appSupportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          theme: ThemeData(
            fontFamily: GoogleFonts.lato().fontFamily,
            primarySwatch: Colors.amber,
          ),
          routes: {
            '/': (_) => const InitView(),
            '/LOGIN': (_) => const LoginView()
          }),
    );
  }
}
