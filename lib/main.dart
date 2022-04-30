import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/init/init_view.dart';
import 'package:framework/store/blocs/store_item_map_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoreItemMapBloc>(create: (_) => StoreItemMapBloc())
      ],
      child: MaterialApp(
          title: 'Framework',
          theme: ThemeData(
            fontFamily: GoogleFonts.lato().fontFamily,
            primarySwatch: Colors.amber,
          ),
          routes: {'/': (_) => const InitView()}),
    );
  }
}
