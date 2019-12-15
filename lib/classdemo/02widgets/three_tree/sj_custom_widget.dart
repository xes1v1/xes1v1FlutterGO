/*
 * Created with Android Studio.
 * User: sunjian
 * Date: 2019-12-07
 * Time: 11:32
 * target: TODO 添加本文件描述信息
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SjCustomWidget extends SingleChildRenderObjectWidget {
  final Color color;
  final double width;
  final double height;
  final Widget child;

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return SjCustomRenderObject(this.color, this.width, this.height);
  }

  @override
  SingleChildRenderObjectElement createElement() => SjCustomElement(this);

  SjCustomWidget(
      {this.color = Colors.white,
      this.width = 10,
      this.height = 10,
      key,
      this.child})
      : super(key: key, child: child);
}

class SjCustomElement extends SingleChildRenderObjectElement {
  SjCustomElement(SjCustomWidget widget) : super(widget);
}

class SjCustomRenderObject extends RenderProxyBox {
  Color color;
  double width;
  double height;

  @override
  void paint(PaintingContext context, Offset offset) {
    print("SjCustomRenderObject  paint");
    var paint = Paint();
    paint.color = color;
    print("x:${offset.dx},Y:${offset.dy},size:${size.width},${size.height}");
    //Offset os = Offset(offset.dx + size.width / 2, offset.dy + size.height / 2);
    context.canvas.drawRect(offset & size, paint);
    //print("x:${os.dx},Y:${os.dy}");
    if (child != null) {
      context.paintChild(child, offset);
    }
  }

  @override
  void performResize() {
    size = constraints.constrain(new Size(width, height));
  }

  @override
  void performLayout() {
    //
    if (child != null) {
      // constraints 这个约束是由parent传递过来
      size = constraints.constrain(new Size(width, height));
      child.layout(constraints,
          parentUsesSize: true); // parentUsesSize 为true是，表示父节点会在自节点重绘的时候，也会重绘
//      size = child.size;
    } else {
      performResize();
    }
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    // TODO: implement handleEvent
    super.handleEvent(event, entry);
    print("SjCustomRenderObject 被点击了");
  }

  @override
  bool hitTestSelf(Offset position) {
    // TODO: implement hitTestSelf
    return true;
  }

  SjCustomRenderObject(this.color, this.width, this.height);
}
