import 'package:flutter/material.dart';

import 'classdemo/02widgets/three_tree/01CustomizeWidget.dart';

void main() => runApp(DogApp());

class DogApp extends StatefulWidget {
  @override
  _DogAppState createState() => _DogAppState();
}

class _DogAppState extends State<DogApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
          child: DogWidget(color: Colors.lightBlue, width: 100, height: 100,)),
//
    );
  }
}
