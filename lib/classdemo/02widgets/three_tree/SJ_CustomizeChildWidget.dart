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

class SjCustomChildRenderObject extends RenderProxyBox
    with DebugOverflowIndicatorMixin {
  Color color;
  double width;
  double height;
  var currentTime = 0;
  Size drawSize;

  @override
  void paint(PaintingContext context, Offset offset) {
    print("dog Offset:${offset.dx},Y:${offset.dy}");
    var paint = Paint();
    paint.color = color;
    context.canvas.drawRect(offset & drawSize, paint);
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
    if (drawSize == null) {
      drawSize = constraints.constrain(new Size(width, height));
    }
    size = drawSize;
  }

  @override
  void performLayout() {
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      size = child.size;
    } else {
      performResize();
    }
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
//        drawSize =
//            Size(Random().nextDouble() * 100, Random().nextDouble() * 100);
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
