import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///
/// Flutter 中只有RenderObject是负责绘制的，而与其对应的真正具有绘制能力的widget
/// 则是RenderObjectWidget， 而其他widget都可以理解为视图的声明或者其他的功能，
/// 最终还是要生成RenderObjectWidget利用RenderObject来进行渲染
///

class DogWidget extends RenderObjectWidget {


  Widget title = null; /// 绘制
  Widget context = null; /// 绘制

  @override
  RenderObjectElement createElement() {

    TitleElement titleElement = title?.createElement();
    Element contextElement = this.context?.createElement();

    return DogElement(this, child: [
      titleElement,
      contextElement
    ]);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return DogRenderObject();
  }
}

class TitleElement extends RenderObjectElement {

  String title;

  TitleElement(DogWidget widget , this.title) : super(widget) ;

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


class DogElement extends RenderObjectElement {

  List<Element> child;

  DogElement(DogWidget widget, {this.child}) : super(widget);

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

/// PaintingContext contxt ?
class DogTitleRenderObject extends RenderProxyBox {

  @override
  void paint(PaintingContext context, Offset offset) {
    // TODO: implement paint
    super.paint(context, offset);
  }
}

class DogRenderObject extends RenderProxyBox {



  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    var paint = Paint();
    paint.color = Colors.lightBlueAccent;
    var size = Size(100, 100);
    context.canvas.drawRect(offset & size, paint);
//    context.canvas.drawRect(Rect.fromLTWH(100, 100, 100, 100), paint);
//    context.canvas.drawRect(rect, paint)
//    context.canvas.drawRect(offset, paint);
  }

  DogRenderObject({
    Offset size,
  });

}
