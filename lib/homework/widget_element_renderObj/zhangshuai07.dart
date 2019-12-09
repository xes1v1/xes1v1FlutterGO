import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CatWidget extends RenderObjectWidget {

  final Color color ;
  final double width;
  final double height;

  @override
  RenderObjectElement createElement() {
    return CatElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return CatRenderObject(this.color, this.width, this.height);
  }

  CatWidget({this.color = Colors.yellow, this.width = 100, this.height = 150, key}):super(key: key);

}

class TitleElement extends RenderObjectElement {
  String title;

  TitleElement(CatWidget widget, this.title) : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {

  }

  @override
  
  void moveChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void forgetChild(Element child) {}
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

/// PaintingContext contxt ?
class CatTitleRenderObject extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    // TODO: implement paint
    super.paint(context, offset);
  }
}

class CatRenderObject extends RenderProxyBox {

  Color color;
  double width;
  double height;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    var paint =  Paint();
    paint.color = color;
    context.canvas.drawCircle(offset, width /2.0, paint);
  }



  CatRenderObject(this.color, this.width, this.height);
}
