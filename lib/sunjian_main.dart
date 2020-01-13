/*
 * Created with Android Studio.
 * User: sunjian
 * Date: 2019-12-07
 * Time: 11:31
 * target: TODO 添加本文件描述信息
 */
import 'package:flutter/material.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/SJ_CustomizeChildWidget.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/sj_custom_widget.dart';

import 'classdemo/02widgets/gesture/AllowMultipleGestureRecognizer.dart';
import 'classdemo/02widgets/gesture/GestureWidget.dart';

void main() => runApp(SjApp());

class SjApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SjAppState();
  }
}

class _SjAppState extends State<SjApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return createWidget2();
  }

  Widget customGestureWidget() {
    return RawGestureDetector(
      gestures: {
        AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            AllowMultipleGestureRecognizer>(
          () => AllowMultipleGestureRecognizer(),
          (AllowMultipleGestureRecognizer instance) {
            instance.onTap =
                () => print('Episode 4 is best! (parent container) ');
          },
        )
      },
      behavior: HitTestBehavior.opaque,
      //Parent Container
      child: Container(
        color: Colors.blueAccent,
        child: Center(
          //Wraps the second container in RawGestureDetector
          child: RawGestureDetector(
            gestures: {
              AllowMultipleGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      AllowMultipleGestureRecognizer>(
                () => AllowMultipleGestureRecognizer(), //constructor
                (AllowMultipleGestureRecognizer instance) {
                  //initializer
                  instance.onTap =
                      () => print('Episode 8 is best! (nested container)');
                },
              )
            },
            //Creates the nested container within the first.
            child: Container(
              color: Colors.yellowAccent,
              width: 300.0,
              height: 400.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget createWidget2() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
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
//          onTap: () {
//            print("内部的.......");
//          },
          onHorizontalDragUpdate: (detail) {
            print("内部的.......");
          },
        ),
      ),
//      onTap: () {
//        print("外部的");
//      },
      onHorizontalDragUpdate: (detail) {
        print("外部的.......");
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

  Widget customWidget() {
    return Container(
      color: Colors.lime,
      child: Center(
        child: SjCustomWidget(
            color: Colors.blueGrey,
            height: 200,
            width: 200,
            child: SjCustomChildWidget(
              width: 100,
              height: 100,
            )),
      ),
    );
  }
}
