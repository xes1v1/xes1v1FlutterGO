import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SjCustomChildWidget extends RenderObjectWidget {
  final Color color;
  final double width;
  final double height;

  @override
  RenderObjectElement createElement() {
    return SjCustomChildElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return SjCustomChildRenderObject(this.color, this.width, this.height);
  }

  SjCustomChildWidget(
      {this.color = Colors.blue, this.width = 10, this.height = 10, key})
      : super(key: key);
}

class SjCustomChildElement extends RenderObjectElement {
  List<Element> child;

  SjCustomChildElement(SjCustomChildWidget widget, {this.child})
      : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {}

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void forgetChild(Element child) {}
}

class SjCustomChildRenderObject extends RenderProxyBox {
  Color color;
  double width;
  double height;
  var currentTime = 0;
  Size drawSize;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    print("SjCustomChildRenderObject:${drawSize.width},${drawSize.height}");
    print("dog Offset:${offset.dx},Y:${offset.dy}");
    var paint = Paint();
    paint.color = color;
//    drawSize = Size(width, height);
    context.canvas.drawRect(offset & drawSize, paint);
  }

  @override
  void performResize() {
    size = constraints.constrain(new Size(width, height));
    drawSize = size;
  }

  @override
  void performLayout() {
    // TODO: implement performLayout
    super.performLayout();
  }

//  @protected
//  bool get sizedByParent => true;

  @override
  bool hitTestSelf(Offset position) {
    // TODO: implement hitTestSelf
    return true;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    // TODO: implement handleEvent
    if (event is PointerDownEvent) {
      currentTime = new DateTime.now().millisecondsSinceEpoch;
    } else if (event is PointerUpEvent) {
      if (DateTime.now().millisecondsSinceEpoch - currentTime < 2000) {
        color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
        drawSize =
            Size(Random().nextDouble() * 100, Random().nextDouble() * 100);
        print(
            "SjCustomChildRenderObject  paint:${drawSize.width},${drawSize.height}");

        markNeedsLayout(); // 标记需要重新布局
        markNeedsPaint(); // 标记需要重绘
      }
    }
    print("SjCustomChildRenderObject 被触摸了");
  }

  SjCustomChildRenderObject(this.color, this.width, this.height);
}
