
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RectChildCustomWidget.dart';
import 'RectCustomWidget.dart';

void main() => runApp(RectApp());

class RectApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RectAppState();
  }
}

class _RectAppState extends State<RectApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime,
      child: Center(
        child: RectCustomWidget(
            color: Colors.blueGrey,
            height: 200,
            width: 200,
            child: RectChildCustomWidget(
              color: Colors.amber,
              width: 100,
              height: 100,
            )),
      ),
    );
  }
}