import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(SjApp());

class SjApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SjAppState();
  }
}

class _SjAppState extends State<SjApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.lime,
      child: Center(
        child: shiyucheng_widget(child: shiyucheng_child_widget())
      ),
    );
  }
}


class shiyucheng_widget extends SingleChildRenderObjectWidget {
  final Widget child;
  shiyucheng_widget({this.child}){
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SycParentRenderObject();
  }
}

class SycParentRenderObject extends RenderProxyBox{

  @override
  void performLayout() {
    if(child != null){
      child.layout(constraints,parentUsesSize: false);
    }
    performResize();
  }

  @override
  void performResize() {
    size = constraints.constrain(new Size(200, 200));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
     var paint = Paint();
     paint.color = Colors.red;
     var rect = offset & size;
     context.canvas.drawRect(rect, paint);
     if(child != null){
       Offset os = Offset(offset.dx + (size.width - child.size.width) / 2,
           offset.dy + (size.height - child.size.height) / 2);
       context.paintChild(child, os);
     }
  }

}

class shiyucheng_child_widget extends SingleChildRenderObjectWidget {

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SycChildRenderObject();
  }
}

class SycChildRenderObject extends RenderProxyBox{
  Color color = Colors.black;
  int index = 0;
  @override
  void performLayout() {
    if(child != null){
      child.layout(constraints,parentUsesSize: false);
    }
    performResize();
  }

  @override
  void performResize() {
    size = constraints.constrain(new Size(100, 100));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var paint = new Paint();
    paint.color =color;
    var rect = offset & size;
    context.canvas.drawRect(rect, paint);
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    print("SycChildRenderObject 被触摸了");
    if(event is PointerDownEvent){
      index++;
      print(index);
      if(index % 2 == 0){
        color = Colors.amber;
      }else{
        color = Colors.black;
      }
      markNeedsLayout(); // 标记需要重新布局
      markNeedsPaint(); // 标记需要重绘
    }
  }

}