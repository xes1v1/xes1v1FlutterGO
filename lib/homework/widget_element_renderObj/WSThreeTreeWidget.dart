/*
 * Created with Android Studio.
 * User: wangshuai
 * Date: 2019-12-05
 * Time: 18:11
 * tartget: TODO 添加本文件描述信息
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WSCatWidget extends RenderObjectWidget {

  final Color color ;
  final double width;
  final double height;

  @override
  RenderObjectElement createElement() {
    return WSCatElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return DogRenderObject(this.color, this.width, this.height);
  }

  WSCatWidget({this.color = Colors.white, this.width = 10, this.height = 10, key}):super(key: key);

}

class WSCatElement extends RenderObjectElement {
  List<Element> child;

  WSCatElement(WSCatWidget widget, {this.child}) : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {}

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void forgetChild(Element child) {}
}

class DogRenderObject extends RenderProxyBox {

  Color color;
  double width;
  double height;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    var paint =  Paint();
    paint.color = color;
    context.canvas.drawCircle(offset, width/2, paint);
  }

  DogRenderObject(this.color, this.width, this.height);
}