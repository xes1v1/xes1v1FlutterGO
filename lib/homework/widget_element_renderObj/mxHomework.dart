//maxu1 create
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MxcatWidget extends RenderObjectWidget
{
    final Color CatColor;
    final double Width;

    @override
    RenderObjectElement createElement(){
        return CatElement(this);
    }
    @override
    RenderObject createRenderObject(BuildContext context){
        return CatRenderObject(CatColor, Width);
    }
    MxcatWidget({this.CatColor = Colors.red, this.Width = 100, key }):super(key:key);
}

class CatElement extends RenderObjectElement {
  List<Element> child;

  CatElement(MxcatWidget widget, {this.child}) : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {}

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void forgetChild(Element child) {}
}

class CatRenderObject extends RenderProxyBox
{
  Color catColor;
  double Width;
  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    var paint =  Paint();
    paint.color = catColor;
    var size = Size(Width, Width);
    context.canvas.drawCircle(offset,Width / 2 , paint);

  }

  CatRenderObject(this.catColor, this.Width);

}