//maxu1 create
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MxcusWidget extends SingleChildRenderObjectWidget {
  final Color color;
  final double width;
  final double height;
  final Widget child;
  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return MxCustomRenderObject(this.color, this.width, this.height);
//    return SjCustomRenderObject(this.color, this.width, this.height);
  }


  @override
  SingleChildRenderObjectElement createElement() {
    return MxCustomElement(this);
  }
  MxcusWidget(
      {this.color = Colors.white,
        this.width = 10,
        this.height = 10,
        key,
        this.child})
      : super(key: key, child: child);

}

class MxCustomElement extends SingleChildRenderObjectElement {
  MxCustomElement(MxcusWidget widget) : super(widget);
}
class MxCustomRenderObject extends RenderProxyBox
    with DebugOverflowIndicatorMixin {
    Color color;
    double width;
     double height;

    @override
    void paint(PaintingContext context, Offset offset) {
      var paint = Paint();
      paint.color = color;
      context.canvas.drawRect(offset & size, paint);

      if (child != null) {
        Offset centerOffset = Offset(offset.dx + (size.width - child.size.width) / 2,
            offset.dy + (size.height - child.size.height) / 2);
        context.paintChild(child, centerOffset);
      }
    }

    @override
    void performResize() {
      size = constraints.constrain(new Size(width, height));
    }

    @override
    void performLayout() {
      if (child != null){
        child.layout(constraints, parentUsesSize: true);
        size = child.size;
      }
      performResize();
    }
    @override
    bool hitTest(BoxHitTestResult result, {Offset position}) {
      Offset tapOs = Offset(position.dx - (size.width - child.size.width) / 2,
          position.dy - (size.height - child.size.height) / 2);
      return super.hitTest(result, position: tapOs);
    }

    @override
    void handleEvent(PointerEvent event, HitTestEntry entry) {
      super.handleEvent(event, entry);
    }

    @override
    bool hitTestSelf(Offset position) {
      return true;
    }

    MxCustomRenderObject(this.color, this.width, this.height);


}