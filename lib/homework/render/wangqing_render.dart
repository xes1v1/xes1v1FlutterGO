/*
 * Created with WangQing.
 * User: WangQing
 * Date: 2019-12-30
 * Time: 10:53
 * target: render
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/01CustomizeWidget.dart';

void main() {
  PictureRecorder recorder = PictureRecorder();
  Canvas canvas = Canvas(recorder);

  Paint p = Paint();
  p.strokeWidth = 30;
  p.color = Color(0xFFFF00FF);

  canvas.drawLine(Offset(300, 300), Offset(800, 800), p);
  canvas.drawLine(Offset(800, 300), Offset(300, 800), p);

  Picture picCross = recorder.endRecording();

  window.onDrawFrame = () {
    int i = DateTime.now().millisecond;

    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    canvas.drawLine(Offset(i * 0.2, 550), Offset(1080 - i * 0.2, 550), p);

    Picture picLine = recorder.endRecording();

    SceneBuilder sceneBuilder = SceneBuilder();
    sceneBuilder.pushOffset(0, 0);
    sceneBuilder.pushOpacity(128);
    sceneBuilder.addPicture(new Offset(0, 0), picCross);
    sceneBuilder.pop();
    sceneBuilder.pushOffset(0, 0.5 * (i - 500));
    sceneBuilder.addPicture(new Offset(0, 0), picLine);
    sceneBuilder.pop();
    sceneBuilder.pop();

    Scene scene = sceneBuilder.build();

    window.render(scene);
    scene.dispose();

    window.scheduleFrame();
  };
  window.scheduleFrame();
}

class WQDogApp extends StatefulWidget {
  Animation<Size> animationSize;
  Animation<Color> animationColor;
  AnimationController controller;

  @override
  _WQDogAppState createState() => _WQDogAppState();
}

class _WQDogAppState extends State<WQDogApp> {
  Animation<Size> animationSize;
  Animation<Color> animationColor;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
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
          width: 200,
          height: 200,
          color: Colors.lightBlue,
          child: DogWidget(
            key: UniqueKey(),
            width: 100,
            height: 100,
          )),
    );
  }
}
