import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// flutter 中，只有RenderObject 负责绘制渲染
/// 而 widget 有众多的子类
/// statelesswidget 与 StateFulWidget 本身都没有ReaderObject
/// 而是通过 build 方法的返回，返回一个 RenderObjectWidget
///
///
/// 1. 需要整理，组合的具体内容， 通过类图和时序图来表示
/// 2. 通过简单的demo来体验 widget  element renderObject 三者的关系， RenderObjectWidget
/// 3. 思考后续通过哪些内容更加深入
///

class DogWidget extends RenderObjectWidget {

  @override
  RenderObjectElement createElement() {
    return DogElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return DogRenderObject();
  }
}

class DogElement extends RenderObjectElement {

  DogElement(DogWidget widget) : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {

  }

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {

  }

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {

  }

  @override
  void forgetChild(Element child) {

  }


}

class DogRenderObject extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    var paint = Paint();
    paint.color = Colors.lightBlueAccent;
    context.canvas.drawRect(Rect.fromLTWH(100, 100, 100, 100), paint);
  }

  DogRenderObject({
    Offset size,
  });
}
