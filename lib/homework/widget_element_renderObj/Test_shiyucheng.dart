import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TestWidget_shiyucheng extends RenderObjectWidget {
  @override
  RenderObjectElement createElement() {
    return TestObjectElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return TestRenderObject();
  }

}


class TestRenderObject extends RenderProxyBox{
   @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    Paint paint = Paint();
    paint.color = Colors.red;
    context.canvas.drawCircle(offset, 80, paint);
  }
}

class TestObjectElement extends RenderObjectElement{
  TestObjectElement(RenderObjectWidget widget) : super(widget);

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
