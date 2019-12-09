import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
///
///2、需要重写hitSelf 返回true表示该widget处理事件
///
/// 不使用GestureDetector时处理事件流程：
/// 1、Hooks内_dispatchPointerDataPacket(ByteData packet)接受native传来的事件流
/// 2、执行GestureBinding的_handlePointerDataPacket(ui.PointerDataPacket packet)方法，转化事件流为逻辑像素点
/// 3、_flushPointerEventQueue,遍历拿出移除存储在_pendingPointerEvents队列内的事件，执行_handlePointerEvent
/// 方法对事件做处理
/// 4、在_handlePointerEvent方法里，判断事件为按下时，执行hitTest方法，hitTest会将符合renderBinding内的hitTest
/// 开始一直执行child的hitTest,将所有符合hitTest的renderBox加到hitTestResult内，最后将GestureBinding添加到hitTestResult
/// 内，并将hitTestResult给到_hitTests map,在抬起时会将事件对应的hitTestResult从——hitTests移除
/// 5、dispatchEvent 遍历hitTestResult.path，执行对应target（一般是RenderBox，或者GestureBinding）的handleEvent方法，
/// 至此我们在renderBox内的重写的handleEvent方法被执行。
///
///使用手势框架：
///
///以点击事件为例：
///真正的事件处理是交给了RenderPointListener，---在创建GestureDetector的时候就根据声明的事件，生成了
///对应的手势识别器---》以单击事件为例：
///GestureDetector-->RawGestureDetector-->Listener-->_PointerListener
///1、RenderPointListener重写了handleEvent方法，判断是down时会回调到GestureDetector内的_handlePointerDown，并将
///该事件添加到所有注册的手势识别器内。
///2、真正执行添加的PrimaryPointerGestureRecognizer内的addAllowedPointer方法--》startTrackingPointer
///3、GestureBinding.instance.pointerRouter.addRoute(pointer, handleEvent, transform);添加到事件路由内
///这个的handleEvent就是当前手势里的handleEvent方法.
///4、GestureBinding.instance.gestureArena.add(pointer, this)，添加到事件竞技场内,会将GestureRecognizerState赋值为ready
///新产生一个_GestureArena，并存储GestureArenaManager的_arenas里，会将当前手势对象天到_GestureArena里维护的一个List内
///5、按下的最后一步会执行GestureBinding内的handleEvent
///pointerRouter.route(event),遍历执行所有注册手势的handleEvent方法再次会判断当前动作是否符合该手势，
///如果不符合会将手势状态标记会拒绝，并从事件竞技场内删除，从路由事件集合内删除
///handlePrimaryPointer(PointerEvent event)，该方法会判断事件是否是抬起，取消，或者是不是点击事件的
///
///
///接着执行gestureArena的close方法,将该事件对应的_GestureArena状态设置为state.isOpen = false，
///执行_tryToResolveArena方法，如果内部成员只有一个，那么将该手势设置为可接受 .
/// 如果不是  _resolveInFavorOf(pointer, state, state.eagerWinner);
/// 这个两个方法做的事就是告诉手势 可以接受还是不接受这个事件、。至此按下事件结束
///
///
/// 抬起时：
/// 会走进手势内的handlePrimaryPointer方法，方法内判断是抬起事件，
/// checkUp---> 回调我们注册进来的点击事件的callback，
/// GestureBinding的gestureArena.sweep(event.pointer);
/// 将事件给到第一个添加到gestureArena内的成员，其他的成员 state.members[i].rejectGesture(pointer);
///
///
///
///
///
///
///
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
    print("size:${size.width},size height:${size.height}");
//    GestureBinding.instance.pointerRouter
//        .addRoute(event.pointer, handleEvent1, event.transform);

//    // TODO: implement handleEvent
    if (event is PointerDownEvent) {
      //isHandle = false;
      currentTime = new DateTime.now().millisecondsSinceEpoch;
    } else if (event is PointerUpEvent) {
      if (DateTime.now().millisecondsSinceEpoch - currentTime < 2000) {
        onTap();
      }
//      //isHandle = false;
    }
  }

  void handleEvent1(PointerEvent event) {
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

  performResize() {
    size = Size(width, height);
  }

//  @override
//  bool get sizedByParent => true;

  DogRenderObject(this.color, this.width, this.height, this.onTap);
}
