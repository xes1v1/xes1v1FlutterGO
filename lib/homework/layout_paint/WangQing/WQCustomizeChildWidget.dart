import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WQCustomChildWidget extends RenderObjectWidget {
  final Color color;
  final double width;
  final double height;

  @override
  RenderObjectElement createElement() {
    return WQCustomChildElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WQCustomChildRenderObject(this.color, this.width, this.height);
  }

  WQCustomChildWidget(
      {this.color = Colors.blue, this.width = 10, this.height = 10, key})
      : super(key: key);
}

class WQCustomChildElement extends RenderObjectElement {
  List<Element> child;

  WQCustomChildElement(WQCustomChildWidget widget, {this.child})
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

class WQCustomChildRenderObject extends RenderProxyBox
    with DebugOverflowIndicatorMixin {
  Color color;
  double width;
  double height;
  var currentTime = 0;

  @override
  void paint(PaintingContext context, Offset offset) {
    print("dog Offset:${offset.dx},Y:${offset.dy}");
    var paint = Paint();
    paint.color = color;
    context.canvas.drawRect(offset & size, paint);
    assert(() {
      final List<DiagnosticsNode> debugOverflowHints = <DiagnosticsNode>[
        ErrorDescription("不符合规则"),
      ];
      Rect rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
      paintOverflowIndicator(context, offset, offset & size, rect,
          overflowHints: debugOverflowHints);
      return true;
    }());
  }

  @override
  void performResize() {
    size = constraints.constrain(new Size(width, height));
  }

  @override
  bool hitTestSelf(Offset position) {
    print("pos:${position.dx},${position.dy}");
    return true;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent) {
      currentTime = new DateTime.now().millisecondsSinceEpoch;
    } else if (event is PointerUpEvent) {
      if (DateTime.now().millisecondsSinceEpoch - currentTime < 2000) {
        color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
        markNeedsLayout(); // 标记需要重新布局
        markNeedsPaint(); // 标记需要重绘
      }
    }
    print("WQCustomChildRenderObject 被触摸了");
  }

  WQCustomChildRenderObject(this.color, this.width, this.height);
}
