import 'package:flutter/material.dart';
import 'package:framework/store/store_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Framework',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StoreView(),
    );
  }
}
