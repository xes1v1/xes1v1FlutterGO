import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(SongWidget());
}

class SongWidget extends RenderObjectWidget {
  SongWidget({Key key}) : super(key: key);

  @override
  RenderObjectElement createElement() {
    return new LiusongElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return LiusongRenderObject();
  }
}

class LiusongRenderObject extends RenderProxyBox {
  @override
  void debugAssertDoesMeetConstraints() {}

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    var paint = Paint();
    paint.color = Colors.red;
    context.canvas.drawCircle(Offset(100, 300), 30, paint);
  }

  @override
  Rect get paintBounds => Rect.fromLTRB(10, 10, 60, 60);

  @override
  void performLayout() {}

  @override
  void performResize() {}

  @override
  Rect get semanticBounds => null;
}

class LiusongElement extends RenderObjectElement {
  LiusongElement(SongWidget widget, {this.child}) : super(widget);

  Element child;

  @override
  void forgetChild(Element child) {
    // TODO: implement forgetChild
  }

  @override
  void insertChildRenderObject(RenderObject child, slot) {
    // TODO: implement insertChildRenderObject
  }

  @override
  void moveChildRenderObject(RenderObject child, slot) {
    // TODO: implement moveChildRenderObject
  }

  @override
  void removeChildRenderObject(RenderObject child) {
    // TODO: implement removeChildRenderObject
  }
}
