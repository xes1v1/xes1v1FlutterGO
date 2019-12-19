/*
 * Created with Android Studio.
 * User: wangshuai
 * Date: 2019-12-19
 * Time: 18:33
 * tartget: TODO 添加本文件描述信息
 */
import 'package:flutter/material.dart';

import 'ws_custom_child_widget.dart';
import 'ws_custom_widget.dart';

void main() => runApp(WSLayoutPaintApp());

class WSLayoutPaintApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WSAppState();
  }
}

class _WSAppState extends State<WSLayoutPaintApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.red,
      child: Center(
        child: WSCustomWidget(
            color: Colors.yellow,
            height: 200,
            width: 200,
            child: WSCustomChildWidget(
              width: 100,
              height: 100,
            )),
      ),
    );
  }
}
