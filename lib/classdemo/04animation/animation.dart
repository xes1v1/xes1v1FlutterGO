import 'package:flutter/material.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/01CustomizeWidget.dart';

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
        SizeTween(begin: Size(10, 10), end: Size(40, 40)).animate(controller)
          ..addListener(() {
            setState(() {});
          });
    animationColor = ColorTween(begin: Colors.purple, end: Colors.lightBlue)
        .animate(controller);
    animationColor.addListener(() {
      setState(() {});
    });
    controller.repeat();
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
          width: 100,
          height: 100,
          color: animationColor.value,
          child: DogWidget(
            key: UniqueKey(),
            width: animationSize.value.width,
            height: animationSize.value.height,
          )),
//    DogWidget(
//              color: animationColor.value,
//              width: animationSize.value.width,
//              height: animationSize.value.height)),
    );
  }
}
