import 'package:flutter/material.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/01CustomizeWidget.dart';
import 'package:flutter_app/sunjian_main.dart';

import 'classdemo/02widgets/gesture/GestureWidget.dart';
import 'classdemo/05render/Mx1render.dart';
void main() {
   Mxmain();
//  return runApp(SjApp());
}

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
    return Container(
      color: Colors.white,
      child: Center(
        child: DogWidget(
          color: Colors.blue,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  Widget createWidget2() {
    return GestureDetector(
      child: Container(
        width: 300,
        height: 300,
        color: Colors.amber,
        child: GestureDetector(
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
          ),
          onTap: () {
            print("内部的.......");
          },
        ),
      ),
      onTap: () {
        print("外部的");
      },
    );
  }

  Widget createWidget1() {
    return GestureDetector(
      child: Container(
        width: 300,
        height: 300,
        color: Colors.amber,
        child: Center(
            child: GestureWidget(
          color: Colors.lightBlue,
          width: 100,
          height: 100,
          onTap: () {
            print("内部的");
          },
        )),
      ),
      onTap: () {
        print("外部的");
      },
    );
  }
}
