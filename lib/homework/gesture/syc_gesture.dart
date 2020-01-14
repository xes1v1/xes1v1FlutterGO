import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(SycWidget());

class SycWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SycState();
  }
}

class SycState extends State<SycWidget>{
  @override
  Widget build(BuildContext context) {
    return customWidget();
  }


  Widget customWidget() {
    return Container(
      color: Colors.lime,
      child: Center(
        child: SycCustomWidget(
            color: Colors.blueGrey,
            height: 200,
            width: 200,
            child: SycCustomChildWidget(
              width: 100,
              height: 100,
            )),
      ),
    );
  }
}

class SycCustomWidget extends SingleChildRenderObjectWidget {
  final Color color;
  final double width;
  final double height;
  final Widget child;

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return SycCustomRenderObject(this.color, this.width, this.height);
  }

  @override
  SingleChildRenderObjectElement createElement() => SycCustomElement(this);

  SycCustomWidget(
      {this.color = Colors.white,
        this.width = 10,
        this.height = 10,
        key,
        this.child})
      : super(key: key, child: child);
}

class SycCustomElement extends SingleChildRenderObjectElement {
  SycCustomElement(SycCustomWidget widget) : super(widget);
}

class SycCustomRenderObject extends RenderProxyBox
    with DebugOverflowIndicatorMixin {
  Color color;
  double width;
  double height;

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    return super.hitTest(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    print("position---->${position.dx},${position.dy}");
    Offset os = Offset(position.dx - (size.width - child.size.width) / 2,
        position.dy - (size.height - child.size.height) / 2);
    print("os---->${os.dx},${os.dy}");
    return super.hitTestChildren(result, position: os);
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    super.handleEvent(event, entry);
    print("CustomRenderObject----handleEvent");
  }

  @override
  bool hitTestSelf(Offset position) {
    return super.hitTestSelf(position);
  }

  SycCustomRenderObject(this.color, this.width, this.height);

  @override
  void paint(PaintingContext context, Offset offset) {
    var paint = Paint();
    paint.color = color;
    context.canvas.drawRect(offset & size, paint);
    if (child != null) {
      //如果child节点不为空时，绘制子节点，在此处将子节点绘制的位置传递下去
      //绘制孩子在中间展示 .
      Offset os = Offset(offset.dx + (size.width - child.size.width) / 2,
          offset.dy + (size.height - child.size.height) / 2);
      context.paintChild(child, os);
    }
  }

  @override
  void performResize() {
    // 该方法确定当前节点的绘制区域 。
    //super.performResize();
    size = constraints.constrain(new Size(width, height));
  }

  @override
  void performLayout() {
    if (child != null) {
      // 如果子节点不为空，向子节点传递约束，并指定当前节点是否受子节点布局变化而变化。
      // parentUsesSize为true表示受影响，false不受影响 。
      child.layout(constraints, parentUsesSize: false);
      //size = child.size;
    } else {
      //performResize();
    }
    performResize();
  }
}


class SycCustomChildWidget extends RenderObjectWidget {
  final Color color;
  final double width;
  final double height;

  @override
  RenderObjectElement createElement() {
    return SycCustomChildElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SycCustomChildRenderObject(this.color, this.width, this.height);
  }

  SycCustomChildWidget(
      {this.color = Colors.blue, this.width = 10, this.height = 10, key})
      : super(key: key);
}

class SycCustomChildElement extends RenderObjectElement {
  List<Element> child;

  SycCustomChildElement(SycCustomChildWidget widget, {this.child})
      : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {}

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void forgetChild(Element child) {}
}

class SycCustomChildRenderObject extends RenderProxyBox
    with DebugOverflowIndicatorMixin {
  Color color;
  double width;
  double height;
  var currentTime = 0;

  @override
  bool hitTestSelf(Offset position) {
    print("pos:${position.dx},${position.dy}");
    return true;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    // TODO: implement handleEvent
    if (event is PointerDownEvent) {
      currentTime = new DateTime.now().millisecondsSinceEpoch;
    } else if (event is PointerUpEvent) {
      if (DateTime.now().millisecondsSinceEpoch - currentTime < 2000) {
        color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
        markNeedsLayout(); // 标记需要重新布局
        markNeedsPaint(); // 标记需要重绘
      }
    }
    print("CustomChildRenderObject 被触摸了");
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    print("dog Offset:${offset.dx},Y:${offset.dy}");
    var paint = Paint();
    paint.color = color;
    context.canvas.drawRect(offset & size, paint);
    assert(() {
      final List<DiagnosticsNode> debugOverflowHints = <DiagnosticsNode>[
        ErrorDescription("不符合规则"),
      ];
      Rect rect = Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
      paintOverflowIndicator(context, offset, offset & size, rect,
          overflowHints: debugOverflowHints);
      return true;
    }());
  }

  @override
  void performResize() {
    size = constraints.constrain(new Size(width, height));
  }

  SycCustomChildRenderObject(this.color, this.width, this.height);
}