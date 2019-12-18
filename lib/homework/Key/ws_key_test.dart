/*
 * Created with Android Studio.
 * User: wangshuai
 * Date: 2019-12-18
 * Time: 17:12
 * tartget: TODO 添加本文件描述信息
 */

import 'package:flutter/material.dart';

Widget keyTestWS() {
  return new MaterialApp(
    home: new KeyTest2(),
  );
}

// 作业

class KeyTest2 extends StatefulWidget {
  KeyTest2({Key key}) : super(key: key);

  @override
  _Key2State createState() => _Key2State();
}

class _Key2State extends State<KeyTest2> {
  bool _open = false;
  final configKey = GlobalKey<SwitchWidgetState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('key test')),
      body: Center(
        child: SwitchWidget(key: configKey,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _open = !_open;
          configKey.currentState.changSwitch(_open);
        },
        child: Icon(Icons.swap_horizontal_circle),
      ),
    );
  }
}

// 一个独立的switch小组件
class SwitchWidget extends StatefulWidget {
  SwitchWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SwitchWidgetState();
}

class SwitchWidgetState extends State<SwitchWidget> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Switch(
          value: _open,
        ),
      ],
    );
  }

  void changSwitch(bool open) {
    setState(() {
      _open = open;
    });
  }
}
