/*
 * Created with Android Studio.
 * User: whqfor
 * Date: 2019-12-13
 * Time: 15:06
 * email: wanghuaqiang@100tal.com
 * tartget: Key 随堂作业
 */

import 'package:flutter/material.dart';

void main() {
  return runApp(keyTest());
}

Widget keyTest() {
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
  final switchKey =  GlobalKey<SwitchWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('key test')),
      body: Center(
        child: SwitchWidget(key: switchKey),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _open = !_open;
          switchKey.currentState.changSwitch(_open);
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

// 例子
class KeyTest1 extends StatefulWidget {
  KeyTest1({Key key}) : super(key: key);

  @override
  _Key1State createState() => _Key1State();
}

class _Key1State extends State<KeyTest1> {
  double value = 0.0;
  final configKey = GlobalKey<ConfigWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('key test')),
      body: Center(
        child: ConfigWidget(key: configKey),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          value += 0.1;
          if (value > 1.0) value = 0.0;
          configKey.currentState.changeSlider(value);
        },
        child: Icon(Icons.swap_horizontal_circle),
      ),
    );
  }
}

// 一个独立的滑动小组件
class ConfigWidget extends StatefulWidget {
  ConfigWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ConfigWidgetState();
}

class ConfigWidgetState extends State<ConfigWidget> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Slider(
          value: _sliderValue,
        )
      ],
    );
  }

  void changeSlider(double sliderValue) {
    setState(() {
      _sliderValue = sliderValue;
    });
  }
}
