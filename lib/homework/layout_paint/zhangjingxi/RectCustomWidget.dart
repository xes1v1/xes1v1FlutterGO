import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class RectCustomWidget extends SingleChildRenderObjectWidget {

  final Color color;
  final double width;
  final double height;
  final Widget child;

  RectCustomWidget({this.color, key, this.width = 10, this.height = 10, this.child}): super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RectCustomRenderObject(color, width, height);
  }

  @override
  SingleChildRenderObjectElement createElement() => RectCustomRenderObjectElement(this);
}

class RectCustomRenderObjectElement extends SingleChildRenderObjectElement {
  RectCustomRenderObjectElement(RectCustomWidget widget) : super(widget);
}

class RectCustomRenderObject extends RenderProxyBox with DebugOverflowIndicatorMixin {

  Color color;
  double width, height;

  RectCustomRenderObject(this.color, this.width, this.height);

  @override
  void performResize() {
    size = constraints.constrain(Size(width, height));
  }

  @override
  void performLayout() {
    if (child != null) {
      child.layout(constraints, parentUsesSize: false);
      //size = child.size;
    }
    performResize();
  }

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
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    Offset os = Offset(position.dx - (size.width - child.size.width) / 2,
        position.dy - (size.height - child.size.height) / 2);
    return super.hitTest(result, position: os);
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }
}