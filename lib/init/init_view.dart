import 'package:flutter/material.dart';
import 'package:framework/init/init_view_model.dart';

class InitView extends StatefulWidget {
  const InitView({Key? key}) : super(key: key);

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  @override
  void initState() {
    super.initState();
    InitViewModel.initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
    );
  }
}
