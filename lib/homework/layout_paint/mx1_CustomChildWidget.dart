//maxu1 create
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MxCustomChildWidget extends RenderObjectWidget {
  final Color color;
  final double width;
  final double height;
  
  @override
  RenderObjectElement createElement() {
    return MxCustomChildElement(this);
  }
  
  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return MxCustomChildRenderObject(this.color, this.width, this.height);
  }
  
  MxCustomChildWidget(
      {this.color = Colors.blue, this.width = 10, this.height = 10, key})
      : super(key: key);

}

class MxCustomChildElement extends RenderObjectElement {
  List<Element> child;

  MxCustomChildElement(MxCustomChildWidget widget, {this.child})
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

class MxCustomChildRenderObject extends RenderProxyBox
    with DebugOverflowIndicatorMixin {
  Color color;
  double width;
  double height;
  var currentTime = 0;

  @override
  void paint(PaintingContext context, Offset offset) {
     var paint = Paint();
     paint.color = color;
     context.canvas.drawRect(offset & size, paint);
  }
  @override
  void performResize() {
    size = constraints.constrain(new Size(width, height));
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }
  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent) {
      currentTime = new DateTime.now().millisecondsSinceEpoch;
    } else if (event is PointerUpEvent) {
      if (DateTime.now().millisecondsSinceEpoch - currentTime < 2000) {
        color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
        markNeedsLayout();
        markNeedsPaint();
      }
    }
  }
  MxCustomChildRenderObject(this.color, this.width, this.height);

}
