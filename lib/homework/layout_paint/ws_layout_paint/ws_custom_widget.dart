/*
 * Created with Android Studio.
 * User: wangshuai
 * Date: 2019-12-19
 * Time: 18:27
 * tartget: TODO 添加本文件描述信息
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WSCustomWidget extends SingleChildRenderObjectWidget {
  final Color color;
  final double width;
  final double height;
  final Widget child;

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return WSCustomRenderObject(this.color, this.width, this.height);
  }

  @override
  SingleChildRenderObjectElement createElement() => WSCustomElement(this);

  WSCustomWidget(
      {this.color = Colors.white,
        this.width = 10,
        this.height = 10,
        key,
        this.child})
      : super(key: key, child: child);
}

class WSCustomElement extends SingleChildRenderObjectElement {
  WSCustomElement(WSCustomWidget widget) : super(widget);
}

class WSCustomRenderObject extends RenderProxyBox
    with DebugOverflowIndicatorMixin {
  Color color;
  double width;
  double height;

  @override
  void paint(PaintingContext context, Offset offset) {
    var paint = Paint();
    paint.color = color;
    context.canvas.drawRect(offset & size, paint);
    if (child != null) {
      Offset os = Offset(offset.dx + (size.width - child.size.width) / 2,
          offset.dy + (size.height - child.size.height) / 2);
      context.paintChild(child, os);
    }
  }

  @override
  void performResize() {
    size = constraints.constrain(new Size(width, height));
  }

  @override
  void performLayout() {
    if (child != null) {
      // 如果子节点不为空，向子节点传递约束，并指定当前节点是否受子节点布局变化而变化。
      // parentUsesSize为true表示受影响，false不受影响 。
      child.layout(constraints, parentUsesSize: true);
      size = child.size;
    } else {
      //performResize();
    }
    performResize();
  }

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    // 在该处也要处理点击事件的偏移量，
    // 与绘制时给子的偏移量相反，如果不处理将导致事件处理异常
    print("position---->${position.dx},${position.dy}");
    Offset os = Offset(position.dx - (size.width - child.size.width) / 2,
        position.dy - (size.height - child.size.height) / 2);
    print("os---->${os.dx},${os.dy}");
    return super.hitTest(result, position: os);
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    super.handleEvent(event, entry);
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  WSCustomRenderObject(this.color, this.width, this.height);
}
