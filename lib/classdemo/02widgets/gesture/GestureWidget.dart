import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class GestureWidget extends RenderObjectWidget {
  final Color color;
  final double width;
  final double height;
  final Function onTap;

  @override
  RenderObjectElement createElement() {
    return DogElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return DogRenderObject(this.color, this.width, this.height, this.onTap);
  }

  GestureWidget(
      {this.color = Colors.white,
      this.width = 10,
      this.height = 10,
      key,
      this.onTap})
      : super(key: key);
}

class TitleElement extends RenderObjectElement {
  String title;

  TitleElement(GestureWidget widget, this.title) : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {}

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {}

  @override
  void forgetChild(Element child) {}
}

class DogElement extends RenderObjectElement {
  List<Element> child;

  DogElement(GestureWidget widget, {this.child}) : super(widget);

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
class DogTitleRenderObject extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    // TODO: implement paint
    super.paint(context, offset);
  }
}

///1、当手势外部container没有设置宽高时，内部需要重写performResize 给size赋值，负责size是（0.0，0.0）
///2、需要重写hitTestSelf 返回true表示该widget处理事件
///3、真正的事件处理是交给了RenderPointListener，---在创建GestureDetector的时候就根据声明的事件，生成了
///对应的手势识别器---》以单击事件为例：
///执行GestureBinding-->_handlePointerEvent该方法内会判断是否是按下事件，如果是会执行hitTest，hitTest会
///依次执行到最内部的widget对应的renderBox内
///执行renderBox内的hitTest---》hitTestChildren，hitSelf判断是否要将当前的renderBox加到HitTestResult内，
///接着会执行gestureBinding内的dispatchEvent--》此时会遍历上一步骤中添加到HitResult内的HitTestEntry，
///执行HitTestEntry内的target的handEvent方法，
///RenderPointerListener的handleEvent的方法，回调到RawGestureDetector内的_handlePointerDown方法
///并将按下（PointerDownEvent）事件添加到手势识别器（在创建时生成的那些）内，
///
///
///
/// 当抬起时，依然会执行target内的handleEvent方法，此时会执行recigizer的handleEvent方法，在执行TapGestureRecognizer
/// 的handlePrimaryPointer--》检测——checkUp，执行invokeCallback<void>('onTap', onTap);最终调用我们传入的
/// onTap回调
class DogRenderObject extends RenderProxyBox {
  Color color;
  double width;
  double height;
  bool isHandle = true;
  Function onTap;
  var currentTime = 0;
  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    var paint = Paint();
    paint.color = color;
    var size = Size(width, height);
    context.canvas.drawRect(offset & size, paint);
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    // TODO: implement handleEvent
    if (event is PointerDownEvent) {
      //isHandle = false;
      currentTime = new DateTime.now().millisecondsSinceEpoch;
    } else if (event is PointerUpEvent) {
      if (DateTime.now().millisecondsSinceEpoch - currentTime < 2000) {
        onTap();
      }
      //isHandle = false;
    }
  }

  @override
  bool hitTestSelf(Offset position) => isHandle;

//  performResize() {
//    size = Size(width, height);
//  }

//  @override
//  bool get sizedByParent => true;

  DogRenderObject(this.color, this.width, this.height, this.onTap);
}
