/*
 * Created with Android Studio.
 * User: whqfor
 * Date: 2019-12-13
 * Time: 15:06
 * email: wanghuaqiang@100tal.com
 * tartget: Key 随堂作业
 */

import 'package:flutter/material.dart';

Widget keyTest() {
  return new MaterialApp(
    home: new KeyTest(),
  );
}

class KeyTest extends StatefulWidget {
  KeyTest({Key key}) : super(key: key);

  @override
  _KeyState createState() => _KeyState();
}

class _KeyState extends State<KeyTest> {
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

// 一个独立的widget小组件
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
