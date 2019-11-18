import 'package:flutter/material.dart';

import 'classdemo/02widgets/three_tree/01CustomizeWidget.dart';

void main() => runApp(DogApp());

class DogApp extends StatefulWidget {
  @override
  _DogAppState createState() => _DogAppState();
}

class _DogAppState extends State<DogApp> with SingleTickerProviderStateMixin {
  Animation<Size> animationSize;
  Animation<Color> animationColor;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animationSize =
        SizeTween(begin: Size(10, 10), end: Size(100, 100)).animate(controller)
          ..addListener(() {
            setState(() {});
          });
    animationColor = ColorTween(begin: Colors.purple, end: Colors.lightBlue)
        .animate(controller);
    animationColor.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
          width: animationSize.value.width,
          height: animationSize.value.height,
          color: animationColor.value,
          child: FlutterLogo()),
//    DogWidget(
//              color: animationColor.value,
//              width: animationSize.value.width,
//              height: animationSize.value.height)),
    );
  }
}
