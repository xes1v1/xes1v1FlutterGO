/*
 * Created with Android Studio.
 * User: wangshuai
 * Date: 2019-12-30
 * Time: 10:50
 * tartget: TODO 添加本文件描述信息
 */
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/01CustomizeWidget.dart';
import 'dart:ui';

void main() {
 test1();
 Future.delayed(Duration(seconds: 10), () {
   test2();
 });
 Future.delayed(Duration(seconds: 10), () {
   test3();
 });
}

void test1() {
  PictureRecorder recorder = PictureRecorder();
  Canvas canvas = Canvas(recorder);

  Paint p = Paint();
  p.strokeWidth = 30.0;
  p.color = Color(0xFFFF00FF);

  canvas.drawLine(Offset(300, 300), Offset(800, 800), p);
  p.color = Color(0xFFFF0000);
  canvas.drawRect(Rect.fromLTRB(400, 400, 100, 100), p);

  Picture picture = recorder.endRecording();

  SceneBuilder sceneBuilder = SceneBuilder();
  sceneBuilder.pushOffset(0, 0);
  sceneBuilder.addPicture(new Offset(0, 0), picture);
  sceneBuilder.pop();
  Scene scene = sceneBuilder.build();

  window.onDrawFrame = (){
    window.render(scene);
  };
  window.scheduleFrame();
}

void test2(){
  PictureRecorder recorder = PictureRecorder();
  Canvas canvas = Canvas(recorder);

  Paint p = Paint();
  p.strokeWidth = 30.0;
  p.color = Color(0xFFFF00FF);

  canvas.drawLine(Offset(300, 300), Offset(800, 800), p);
  canvas.drawLine(Offset(800, 300), Offset(300, 800), p);

  Picture picCross = recorder.endRecording();

  window.onDrawFrame = (){

    int i = DateTime.now().millisecond;

    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    canvas.drawLine(Offset(i*0.2, 550), Offset(1080-i*0.2, 550), p);

    Picture picLine = recorder.endRecording();

    SceneBuilder sceneBuilder = SceneBuilder();
    sceneBuilder.pushOffset(0, 0);
    sceneBuilder.pushOpacity(128);
    sceneBuilder.addPicture(new Offset(0, 0), picCross);
    sceneBuilder.pop();
    sceneBuilder.pushOffset(0, 0.5*(i-500));
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

Widget test3() {
  return DogApp();
}

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