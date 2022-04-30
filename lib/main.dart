import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/store/blocs/store_item_map_bloc.dart';
import 'package:framework/store/store_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoreItemMapBloc>(create: (_) => StoreItemMapBloc())
      ],
      child: MaterialApp(
          title: 'Framework',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {'/': (_) => const StoreView()}),
    );
  }
}
