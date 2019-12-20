/*
 * Created with Android Studio.
 * User: workmac
 * Date: 2019-12-19
 * Time: 18:14
 * target: 
 */
import 'dart:ui';

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
        child: LGCustomWidget(
            color: Colors.blueGrey,
            height: 200,
            width: 200,
            child: LGCustomWidget(
              width: 100,
              height: 100,
            )),
      ),
    );
  }
}

class LGCustomWidget extends SingleChildRenderObjectWidget {
  final Color color;
  final double width;
  final double height;
  final Widget child;

  LGCustomWidget(
      {this.color = Colors.white,
        this.width = 10,
        this.height = 10,
        key,
        this.child})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return LGCustomRenderObject(this.color, this.width, this.height);
  }

  @override
  SingleChildRenderObjectElement createElement() {
    // TODO: implement createElement
    return LGCustomElement(this);
  }

}

class LGCustomElement extends SingleChildRenderObjectElement {
  LGCustomElement(LGCustomWidget widget) : super(widget);
}

class LGCustomRenderObject extends RenderProxyBox
     with DebugOverflowIndicatorMixin {

   Color color;
   double width;
   double height;

   LGCustomRenderObject(this.color, this.width, this.height);

   @override
   void paint(PaintingContext context, Offset offset) {
    // TODO: implement paint
     var paint = Paint();
     paint.color = color;
     context.canvas.drawRect(offset & size, paint);

    super.paint(context, offset);
  }

  @override
  void performResize() {
    // TODO: implement performResize
    size = constraints.constrain(Size(width, height));
  }

  @override
  void performLayout() {
    // TODO: implement performLayout
    if(child != null) {
      child.layout(constraints, parentUsesSize: false);
      size = child.size;
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

 }
