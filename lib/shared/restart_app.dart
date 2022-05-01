import 'package:flutter/material.dart';

///Definitelly not the best usability
//
///The App views should depend on InheritedWidget to rebuild itself properly
///when the user changes the language
class RestartAppWidget extends StatefulWidget {
  const RestartAppWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartAppWidgetState>()!.restartApp();
  }

  @override
  State<RestartAppWidget> createState() => _RestartAppWidgetState();
}

class _RestartAppWidgetState extends State<RestartAppWidget> {
  Key key = UniqueKey();

  restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
