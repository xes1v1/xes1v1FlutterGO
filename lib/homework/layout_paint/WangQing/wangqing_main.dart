/*
 * Created with Android Studio.
 * User: sunjian
 * Date: 2019-12-07
 * Time: 11:31
 * target: TODO 添加本文件描述信息
 */
import 'package:flutter/material.dart';

import 'WQCustomWidget.dart';
import 'WQCustomizeChildWidget.dart';

void main() => runApp(WQApp());

class WQApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WQAppState();
  }
}

class _WQAppState extends State<WQApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime,
      child: Center(
        child: WQCustomWidget(
            color: Colors.blueGrey,
            height: 200,
            width: 200,
            child: WQCustomChildWidget(
              width: 100,
              height: 100,
            )),
      ),
    );
  }
}
