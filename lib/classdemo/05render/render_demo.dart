import 'dart:io';
import 'dart:ui' as prefix0;

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
///
///
///
/// 在flutter中几乎所有的绘制都会在 renderObject 以 layer 的方式进行绘制
/// [RenderObject] bool get isRepaintBoundary => false;
///
/// 在isRepaintBoundary = true 的RenderObject 子类中，在重新绘制的时候，系统会自动
/// 创建OffsetLayer ，然后通过 [PaintingContext] appendLayer() addLayer() 等方法来来进行
/// 追加到 [RenderView] _updateMatricesAndCreateNewRootLayer  方法所产生的layer中，此时创建的是TransformLayer
/// 当屏幕发生变化是，[RenderView] configuration 方法触发会 replaceRootLayer
///
///
/// RenderObject  isRepaintBoundary = true 的 RenderObject 只存在几类
///  |
///   [RenderViewportBase]
///  |
///   [RenderRepaintBoundary]  ===>  [RepaintBoundary] widget
///  |
///   [RenderAndroidView]
///  |
///   [RenderFlow]   ===>  [Flow]  widget
///  |
///   [RenderUiKitView]  ====> []
///  |
///   [TextureBox]
///  |
///   [PlatformViewRenderBox]
///  |
///   [RenderView]  ====>  [RenderObjectToWidgetAdapter] widget
///  |
///   [RenderListWheelViewport]  ===> [ListWheelViewport] widget
///
///   isRepaintBoundary = true 时， 将首先停掉上一个layer 并且生成 Picture
///
///   细节详见 [PaintingContext] paintChild()  关键内容
///  if (child.isRepaintBoundary) {
///      stopRecordingIfNeeded();  // 完成之前图层渲染
///      _compositeChild(child, offset); // 只渲染自己图层
///    } else {
///      child._paintWithContext(this, offset);
///    }
///
///   [RenderObject] 中的 markNeedsPaint ，会一直向 parent 递归，找到 isRepaintBoundary 的RenderObject
///   加入到渲染列表中。
///   所以flutter的框架中，渲染只会渲染 layer ，如果不存在上述 isRepaintBoundary = true 的 RenderObject
///   则会将所有元素绘制到  RenderView 也就是我们所说的 rootView 所创建的 Layer 上。
///
///   目前还有的遗留问题： engine 如何缓存 Layer 达到 layer 的重排，缓存优化
///

//void main() => runApp(DogApp());

//简单
//void main() {
//  PictureRecorder recorder = PictureRecorder();
//  Canvas canvas = Canvas(recorder);
//
//  Paint p = Paint();
//  p.strokeWidth = 30.0;
//  p.color = Color(0xFFFFFFFF);
//  canvas.drawRect(Rect.fromLTRB(400, 400, 50, 50), p);
//
//  Picture picture = recorder.endRecording();
//  SceneBuilder sceneBuilder = SceneBuilder();
//  sceneBuilder.pushOffset(0, 0);
//
//  window.onDrawFrame = () {
//
//    double width = (window.physicalSize.width - 400) / 2;
//    double height = (window.physicalSize.height - 350) / 2;
//
//    sceneBuilder.addPicture(new Offset(width, height), picture);
//    sceneBuilder.pop();
//    Scene scene = sceneBuilder.build();
//    window.render(scene);
//    scene.dispose();
//  };
//  window.scheduleFrame();
//}
//  条形码扫描
void main() {
  PictureRecorder recorder = PictureRecorder();
  Canvas canvas = Canvas(recorder);

  Paint p = Paint();
  p.strokeWidth = 30.0;
  p.color = Color(0xFFFFFFFF);
  canvas.drawRect(Rect.fromLTRB(400, 400, 50, 50), p);

  Picture picture =  recorder.endRecording();

  double width = (window.physicalSize.width - 400) / 2;
  double height = (window.physicalSize.height - 350) / 2;
  double gaph = 0;

  int gap = 10;


  window.onDrawFrame = () {

    SceneBuilder sceneBuilder = SceneBuilder();
    sceneBuilder.pushOffset(0, 0);
    sceneBuilder.pushOpacity(128);
    sceneBuilder.addPicture(new Offset(width, height), picture);
    sceneBuilder.pop();

    // 加根线
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    p.color = Color(0xFFFF00FF);

    canvas.drawLine(Offset(420, 40), Offset(20, 40), p);
    Picture picLine = recorder.endRecording();

    if (gaph >  350 ) {
      gaph = 0;
    }
    gaph += gap;

    sceneBuilder.pushOffset(0, gaph);
    sceneBuilder.addPicture(new Offset(width, height), picLine);
    sceneBuilder.pop();

    // 绘制
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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: DogWidget(
      width: 200,
      height: 200,
    ));
  }
}
