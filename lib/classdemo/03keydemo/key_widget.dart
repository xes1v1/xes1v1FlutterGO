/*
 * Created with Android Studio.
 * User: whqfor
 * Date: 2019-10-17
 * Time: 17:41
 * email: wanghuaqiang@100tal.com
 * tartget: 知识点key demo及总结
 */

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(DemoKeys());
}

class DemoKeys extends StatefulWidget {
  DemoKeys({Key key}) : super(key: key);

  @override
  _DemoKeyState createState() => _DemoKeyState();
}

class _DemoKeyState extends State<DemoKeys> {
  List<Widget> widgets = [
    // 场景一：stateless
//    StatelessContainer(),
//    StatelessContainer(),

// 场景二：stateful without key
//    StatefulContainer(),
//    StatefulContainer(),

// 场景三：stateful with key
//    StatefulContainer(key: UniqueKey()),
//    StatefulContainer(key: UniqueKey()),

// 场景四：padding with key 测试key作用层级
    Padding(
//      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatefulContainer(
        key: UniqueKey(),
      ),
    ),
    Padding(
//      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatefulContainer(
        key: UniqueKey(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Key',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: switchWidget,
          child: Icon(Icons.swap_horizontal_circle),
        ),
      ),
    );
  }

  switchWidget() {
    // 交换两个widget
    widgets.insert(0, widgets.removeAt(1));
    setState(() {});
  }
}

class StatelessContainer extends StatelessWidget {
  final Color color = randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}

class StatefulContainer extends StatefulWidget {
  StatefulContainer({Key key}) : super(key: key);
  @override
  _StatefulContainerState createState() => _StatefulContainerState();
}

class _StatefulContainerState extends State<StatefulContainer> {
  final Color color = randomColor();

  @override
  Widget build(BuildContext context) {
    print('StatefulContainerState build');
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}

Color randomColor() {
  return Color.fromARGB(255, Random.secure().nextInt(255),
      Random.secure().nextInt(255), Random.secure().nextInt(255));
}

/// The [State] instance associated with this location in the tree.
///
/// There is a one-to-one relationship between [State] objects and the
/// [StatefulElement] objects that hold them. The [State] objects are created
/// by [StatefulElement] in [mount].
