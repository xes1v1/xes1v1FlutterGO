/*
 * Created with WangQing.
 * User: WangQing
 * Date: 2019-12-19
 * Time: 18:26
 * target: layout_paint
 */
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WQCustomWidget extends SingleChildRenderObjectWidget {
  final Color color;
  final double width;
  final double height;
  final Widget child;

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return WQCustomRenderObject(this.color, this.width, this.height);
  }

  @override
  SingleChildRenderObjectElement createElement() => WQCustomElement(this);

  WQCustomWidget(
      {this.color = Colors.white,
      this.width = 10,
      this.height = 10,
      key,
      this.child})
      : super(key: key, child: child);
}

class WQCustomElement extends SingleChildRenderObjectElement {
  WQCustomElement(WQCustomWidget widget) : super(widget);
}

class WQCustomRenderObject extends RenderProxyBox
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
      Offset os = Offset(offset.dx + (size.width - child.size.width) / 2,
          offset.dy + (size.height - child.size.height) / 2);
      context.paintChild(child, os);
    }
  }

  @override
  void performResize() {
    size = constraints.constrain(new Size(width, height));
  }

  @override
  void performLayout() {
    if (child != null) {
//      child.layout(constraints, parentUsesSize: true);
//      size = child.size;

      child.layout(constraints, parentUsesSize: false);
      //size = child.size;
    } else {
      //performResize();
    }
    performResize();
  }

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    print("position---->${position.dx},${position.dy}");
    Offset os = Offset(position.dx - (size.width - child.size.width) / 2,
        position.dy - (size.height - child.size.height) / 2);
    print("os---->${os.dx},${os.dy}");
    return super.hitTest(result, position: os);
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    super.handleEvent(event, entry);
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  WQCustomRenderObject(this.color, this.width, this.height);
}
