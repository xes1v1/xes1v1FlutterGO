/*
 * Created with WangQing.
 * User: WangQing
 * Date: 2019-12-05
 * Time: 17:41
 * target: 自定义 RenderObject
 */
import 'dart:ui';

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
    paint.style = PaintingStyle.fill;

    var size = Size(100, 100);

//    context.canvas.drawCircle(offset, radius, paint);
//    context.canvas.drawLine(Offset(200, 200), Offset(100, 300), paint);
//    drawPentagram(context, paint);
//    drawRect(context, offset, size, paint);

    List list = [
      [Offset(200, 400), Offset(100, 400), Offset(200, 500)],
      [Offset(100, 300), Offset(300, 300), Offset(250, 400)],
    ];

    for (int i = 0; i < list.length; i++) {
      drawTriangle(context, list[i], paint);
    }
  }

  void drawTriangle(PaintingContext context, List list, Paint paint) {
    context.canvas.drawVertices(
        Vertices(VertexMode.triangleStrip, list), BlendMode.multiply, paint);
  }

  /// 绘制矩形
  void drawRect(
      PaintingContext context, Offset offset, Size size, Paint paint) {
    context.canvas.drawRect(offset & size, paint);
  }

  /// 绘制五角星形状
  void drawPentagram(PaintingContext context, Paint paint) {
    context.canvas.drawLine(Offset(100, 300), Offset(300, 300), paint);
    context.canvas.drawLine(Offset(300, 300), Offset(150, 400), paint);
    context.canvas.drawLine(Offset(150, 400), Offset(200, 200), paint);
    context.canvas.drawLine(Offset(200, 200), Offset(250, 400), paint);
    context.canvas.drawLine(Offset(250, 400), Offset(100, 300), paint);
  }

  WQRenderObject(this.color, this.radius);
}

class WQWidgetNew extends StatefulWidget {
  @override
  _WQWidgetNewState createState() => _WQWidgetNewState();
}

class _WQWidgetNewState extends State<WQWidgetNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: WQWidget(),
      ),
    );
  }
}
