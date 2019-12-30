//maxu1 create
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


void main(){
  PictureRecorder recorder = PictureRecorder();
  Canvas can = Canvas(recorder);

  Paint pa = Paint();
  pa.strokeWidth = 20;
  pa.color = Color(0xFFFF00FF);

  can.drawLine(Offset(300, 300), Offset(800, 800), pa);
  can.drawLine(Offset(800, 300), Offset(300, 800), pa);

  Picture pic = recorder.endRecording();

  window.onDrawFrame =  () {
    int i = DateTime.now().millisecond;
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    canvas.drawLine(Offset(i*0.2, 550), Offset(1080-i*0.2, 550), pa);
    Picture picl  = recorder.endRecording();
    SceneBuilder scenb = SceneBuilder();
    scenb.pushOffset(0, 0);
    scenb.pushOpacity(128);
    scenb.addPicture(Offset(0, 0), pic);
    scenb.pop();
    scenb.pushOffset(0, 0.5*(i-500));
    scenb.addPicture(new Offset(0, 0), picl);
    scenb.pop();
    scenb.pop();
    Scene scene = scenb.build();
    window.render(scene);
    scene.dispose();
    window.scheduleFrame();
  };
  window.scheduleFrame();

}