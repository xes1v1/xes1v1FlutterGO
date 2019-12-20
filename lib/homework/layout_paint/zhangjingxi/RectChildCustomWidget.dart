import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RectChildCustomWidget extends RenderObjectWidget {

  final Color color;
  final double width;
  final double height;

  RectChildCustomWidget({this.color = Colors.blue, this.width = 10, this.height = 10, key})
      : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RectChildRenderObject(color, width, height);
  }

  @override
  RenderObjectElement createElement() => RectChildRenderObjectElement(this);
}

class RectChildRenderObjectElement extends RenderObjectElement {
  List<Element> child;

  RectChildRenderObjectElement(RectChildCustomWidget widget, {this.child})
      : super(widget);

  @override
  void forgetChild(Element child) {
  }

  @override
  void insertChildRenderObject(RenderObject child, slot) {
  }

  @override
  void moveChildRenderObject(RenderObject child, slot) {
  }

  @override
  void removeChildRenderObject(RenderObject child) {
  }
}

class RectChildRenderObject extends RenderProxyBox {

  Color color;
  double width;
  double height;
  var currentTime = 0;

  RectChildRenderObject(this.color, this.width, this.height);

  @override
  void performResize() {
    size = constraints.constrain(Size(width, height));
  }

  @override
  void performLayout() {
    super.performLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var paint = Paint();
    paint.color = color;
    context.canvas.drawRect(offset & size, paint);
  }

  @override
  bool hitTestSelf(Offset position) {
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
        markNeedsLayout(); // 标记需要重新布局
        markNeedsPaint(); // 标记需要重绘
      }
    }
    print("SjCustomChildRenderObject 被触摸了");
  }
}