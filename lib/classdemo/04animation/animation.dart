import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/01CustomizeWidget.dart';
import 'dart:ui';

/// paint 通过层层调用
/// 会调用到 [RendererBinding] drawFrame
/// 在经历
///   pipelineOwner.flushLayout();
///   pipelineOwner.flushCompositingBits();
///   pipelineOwner.flushPaint();
///   这三个过程后，只针对于 大小，位置，像素点 进行调整
///   并将调整后的内容 paint 到 canvas 中, 此时并没有将指令发送到gpu
///   renderView.compositeFrame(); // this sends the bits to the GPU
///
/// /// Uploads the composited layer tree to the engine.
///  ///
///  /// Actually causes the output of the rendering pipeline to appear on screen.
///  void compositeFrame() {
///    Timeline.startSync('Compositing', arguments: timelineWhitelistArguments);
///    try {
///      final ui.SceneBuilder builder = ui.SceneBuilder();
///      final ui.Scene scene = layer.buildScene(builder);
///      if (automaticSystemUiAdjustment)
///        _updateSystemChrome();
///      _window.render(scene);   // 渲染内容会知道window上
///      scene.dispose();
///      assert(() {
///        if (debugRepaintRainbowEnabled || debugRepaintTextRainbowEnabled)
///          debugCurrentRepaintColor = debugCurrentRepaintColor.withHue((debugCurrentRepaintColor.hue + 2.0) % 360.0);
///        return true;
///      }());
///    } finally {
///      Timeline.finishSync();
///    }
///  }
///
/// 几个关键的与GPU有关的类
/// view.dart 中
/// RenderView.compositeFrame() 方法中
///  final ui.SceneBuilder builder = ui.SceneBuilder();  ？
///  final ui.Scene scene = layer.buildScene(builder);   ？
///  _window.render(scene);   // 渲染内容会知道window上
///      scene.dispose();
///
///
///  RenderObjectWidget --> 通过createRenderObject 将必要信息赋值给 renderObject
///  那么当 size 改变时，为了不使所有的树都遍历，所以使用isRepaintBoundary来进行节点终止
///  这里需要让大家了解栅格化 以及 flutter 的 GPU 绘制原理
///
///  https://xieguanglei.github.io/blog/post/flutter-code-chapter-01.html
///  https://xieguanglei.github.io/blog/post/flutter-code-chapter-02.html
///
///  1. 解答昨天遗留的问题， 在
///    RenderDecoratedBox.paint 里面 _BoxDecorationPainter.paint
///     绘制了 Container 的内容 _painter.paint(context.canvas, offset, filledConfiguration);
///     然后才是 DogWidget 的内容
///

//void main() => runApp(DogApp());
//
//void main(){
//
//  // dart ui
//  // https://api.flutter.dev/flutter/dart-ui/dart-ui-library.html
//  PictureRecorder recorder = PictureRecorder();
//  Canvas canvas = Canvas(recorder);
//
//  Paint p = Paint();
//  p.strokeWidth = 30.0;
//  p.color = Color(0xFFFF00FF);
//
//  canvas.drawLine(Offset(300, 300), Offset(800, 800), p);
//  // 解释，为什么在统一图层，
//  p.color = Color(0xFFFF0000);
//  canvas.drawRect(Rect.fromLTRB(400, 400, 100, 100), p);
//
//  Picture picture = recorder.endRecording();
//
//  SceneBuilder sceneBuilder = SceneBuilder();
//  sceneBuilder.pushOffset(0, 0);
//  sceneBuilder.addPicture(new Offset(0, 0), picture);
//  sceneBuilder.pop();
//  Scene scene = sceneBuilder.build();
//
//  window.onDrawFrame = (){
//    window.render(scene);
//  };
//  window.scheduleFrame();
//}

void main(){

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

//    controller = new AnimationController(
//        duration: const Duration(milliseconds: 2000), vsync: this);
//    animationSize =
//        SizeTween(begin: Size(10, 10), end: Size(40, 40)).animate(controller)
//          ..addListener(() {
//            setState(() {});
//          });
//    animationColor = ColorTween(begin: Colors.purple, end: Colors.lightBlue)
//        .animate(controller);
//    animationColor.addListener(() {
//      setState(() {});
//    });
//    controller.forward();
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
//    DogWidget(
//              color: animationColor.value,
//              width: animationSize.value.width,
//              height: animationSize.value.height)),
    );
  }
}
