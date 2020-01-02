import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  PictureRecorder recorder = PictureRecorder();
  Canvas can = Canvas(recorder);
  Paint paint = Paint();
  paint.strokeWidth = 20;
  paint.color = Color(0xFFFF00FF);
  can.drawLine(Offset(300, 300), Offset(800, 800), paint);
  can.drawLine(Offset(800, 300), Offset(300, 800), paint);
  Picture picture = recorder.endRecording();

  window.onDrawFrame = () {
    int i = DateTime.now().millisecond;
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    canvas.drawLine(Offset(i * 0.2, 550), Offset(1080 - i * 0.2, 550), paint);
    Picture picLine = recorder.endRecording();

    SceneBuilder sb = SceneBuilder();
    sb.pushOffset(0, 0);
    sb.pushOpacity(128);
    sb.addPicture(Offset(0, 0), picture);
    sb.pop();
    sb.pushOffset(0, 0.5 * (i - 500));
    sb.addPicture(new Offset(0, 0), picLine);
    sb.pop();

    Scene scene = sb.build();
    window.render(scene);
    scene.dispose();
    window.scheduleFrame();
  };
  window.scheduleFrame();
}
