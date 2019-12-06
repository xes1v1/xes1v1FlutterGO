/*
 * Created with WangQing.
 * User: WangQing
 * Date: 2019-12-05
 * Time: 17:41
 * target: 自定义 RenderObject
 */
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WQWidget extends RenderObjectWidget {
  @override
  RenderObjectElement createElement() {
    return WQElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WQRenderObject(Colors.red, 80);
  }
}

class WQElement extends RenderObjectElement {
  List<Element> child;

  WQElement(WQWidget widget, {this.child}) : super(widget);

  @override
  void forgetChild(Element child) {}

  @override
  void insertChildRenderObject(RenderObject child, slot) {}

  @override
  void moveChildRenderObject(RenderObject child, slot) {}

  @override
  void removeChildRenderObject(RenderObject child) {}
}

class WQRenderObject extends RenderProxyBox {
  Color color;
  double radius;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    var paint = Paint();
    paint.color = color;

//    context.canvas.drawCircle(offset, radius, paint);
//
//    context.canvas.drawLine(Offset(200, 200), Offset(100, 300), paint);
//    context.canvas.drawLine(Offset(200, 200), Offset(300, 300), paint);
//    context.canvas.drawLine(Offset(250, 400), Offset(300, 300), paint);
//    context.canvas.drawLine(Offset(150, 400), Offset(250, 400), paint);
//    context.canvas.drawLine(Offset(100, 300), Offset(150, 400), paint);

//    var size = Size(100, 100);
//    var size = Size(width, height);
//    context.canvas.drawRect(offset & size, paint);

//    context.canvas.drawLine(Offset(200, 200), Offset(100, 300), paint);

    context.canvas.drawLine(Offset(100, 300), Offset(300, 300), paint);
    context.canvas.drawLine(Offset(300, 300), Offset(150, 400), paint);
    context.canvas.drawLine(Offset(150, 400), Offset(200, 200), paint);
    context.canvas.drawLine(Offset(200, 200), Offset(250, 400), paint);
    context.canvas.drawLine(Offset(250, 400), Offset(100, 300), paint);
  }

  WQRenderObject(this.color, this.radius);
}
