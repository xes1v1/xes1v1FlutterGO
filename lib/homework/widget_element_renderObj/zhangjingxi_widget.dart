
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CatWidget extends RenderObjectWidget {

  final Color color;
  final double radius;

  CatWidget({this.color = Colors.blue, this.radius = 90});

  @override
  RenderObjectElement createElement() {
    return CatElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CatRenderObject(color, radius);
  }
}

class CatElement extends RenderObjectElement {
  List<Element> child;

  CatElement(CatWidget widget, {this.child}) : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {}

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void forgetChild(Element child) {}
}

class CatRenderObject extends RenderProxyBox {

  Color color;
  double radius;

  CatRenderObject(this.color, this.radius);

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    Paint paint = Paint();
    paint.color = color;
    context.canvas.drawCircle(offset, radius, paint);
  }
}