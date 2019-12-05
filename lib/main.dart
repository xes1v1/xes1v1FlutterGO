import 'package:flutter/material.dart';

import 'classdemo/02widgets/gesture/GestureWidget.dart';
import 'homework/widget_element_renderObj/wangqing_three_tree.dart';

void main() => runApp(WQWidgetNew());

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
    return createWidget1();
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

  Widget createWQ() {
    return Icon(Icons.ac_unit);
  }
}

class WQWidgetNew extends StatefulWidget {
  @override
  _WQWidgetNewState createState() => _WQWidgetNewState();
}

class _WQWidgetNewState extends State<WQWidgetNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: WQWidget(),
      ),
    );
  }
}
