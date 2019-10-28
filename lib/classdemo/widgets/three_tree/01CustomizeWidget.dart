import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

///
/// Flutter 中只有RenderObject是负责绘制的，而与其对应的真正具有绘制能力的widget
/// 则是RenderObjectWidget， 而其他widget都可以理解为视图的声明或者其他的功能，
/// 最终还是要生成RenderObjectWidget利用RenderObject来进行渲染
///
/// 通过 项目目录中
/// 我们可以看到
///
/// 通过启动流程中的 attachRootWidget
/// 的调用链 learnfile/widget-element产生链.jpg
///
/// ```
///  void runApp(Widget app) {
///     WidgetsFlutterBinding.ensureInitialized()
///    ..attachRootWidget(app)
///    ..scheduleWarmUpFrame();
///  }
/// ```
///
///  ------ 执行链讲解 ------
///  [root] - RenderObjectToWidgetAdapter     [root] - RootRenderObjectElement(RenderObjectToWidgetElement)
///  通过 RenderObjectToWidgetAdapter.attachToRenderTree 与 RootRenderObjectElement
///  👇 （高能：此处是 RenderObjectToWidgetElement mount 的实现）
///  RenderObjectToWidgetElement.mount()  绘制万物的起源
///  👇
///  RenderObjectToWidgetElement._rebuild()  万物创建的起源
///  👇
///  _child = updateChild(_child, widget.child, _rootChildSlot);
///     👁                  👁          👁            👁
/// 【 DogApp              null       DogApp         常量值 】     ----  实际运行时内容
///  👇
///  RenderObjectToWidgetElement.inflateWidget( newWidget )  开始创建了
///                                               👁
///                                              DogApp
///  👇
///   final Element newChild = newWidget.createElement();
///                   👁
///                   DogApp
///   👇
///   newChild.mount(this,                           newSlot);
///                    👁                                 👁
///                  RenderObjectToWidgetElement      _rootChildSlot
///    👇 （高能, 开始是 ComponentElement的 mount 这里之后的循环）
///    ComponentElement.mount(Element parent, dynamic newSlot)
///    👇
///    ComponentElement._firstBuild() -> Element.rebuild()
///    👇
///    ComponentElement.performRebuild()
///               built = build();
///                👁
///               MaterialApp
///    👇
///    Element.updateChild(Element child, Widget newWidget, dynamic newSlot)
///       👁                       👁           👁              👁
///       DogApp                 null        MaterialApp      _rootChildSlot
///
///    👇
///    Element.inflateWidget(Widget newWidget, dynamic newSlot)
///     👁                           👁              👁
///      DogApp                    MaterialApp    _rootChildSlot
///
///    final Element newChild = newWidget.createElement();  MaterialApp是StatefulWidget所以返回的element是StatefulElement
///                  newChild.mount(this, newSlot);
///                    👁
///                  StateFulElement的mount
///
///    👇 （高能：此处实际上是上一步的 newChild.mount 也就是 StatefulElement ）
///     StateFulElement.mount(Element parent, dynamic newSlot)
///                               👁             👁
///                               DogApp         _rootChildSlot
///
///
///    所有总结一下，
///    RenderObjectToWidgetElement的 _rebuild 通过 构造方法传入 root widget 然后添加到 rootElement中
///    之后的
///    内部的element则通过
///    ComponentElement.mount 来把build() 中的widget 所生成的 element 添加到 element关系中
///
///    两处高能的部分，就是一致遍历通过 mount--> _firstBuild() ---> inflateWidget() -->  mount()
///    通过 RenderObjectToWidgetElement ，ComponentElement 的不同的 mount实现将
///    root 与 整个 element 创建了出来。
///
///
///    PS: reBuild 会有一点不同。 这里只是创建过程。
///
///
///

class DogWidget extends RenderObjectWidget {


  Widget title = null; /// 绘制
  Widget context = null; /// 绘制

  @override
  RenderObjectElement createElement() {

    TitleElement titleElement = title?.createElement();
    Element contextElement = this.context?.createElement();

    return DogElement(this, child: [
      titleElement,
      contextElement
    ]);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return DogRenderObject();
  }
}

class TitleElement extends RenderObjectElement {

  String title;

  TitleElement(DogWidget widget , this.title) : super(widget) ;

  @override
  void removeChildRenderObject(RenderObject child) {

  }

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {

  }

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {

  }

  @override
  void forgetChild(Element child) {

  }

}


class DogElement extends RenderObjectElement {

  List<Element> child;

  DogElement(DogWidget widget, {this.child}) : super(widget);

  @override
  void removeChildRenderObject(RenderObject child) {

  }

  @override
  void moveChildRenderObject(RenderObject child, dynamic slot) {

  }

  @override
  void insertChildRenderObject(RenderObject child, dynamic slot) {

  }

  @override
  void forgetChild(Element child) {

  }
}

/// PaintingContext contxt ?
class DogTitleRenderObject extends RenderProxyBox {

  @override
  void paint(PaintingContext context, Offset offset) {
    // TODO: implement paint
    super.paint(context, offset);
  }
}

class DogRenderObject extends RenderProxyBox {

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    var paint = Paint();
    paint.color = Colors.lightBlueAccent;
    var size = Size(100, 100);
    context.canvas.drawRect(offset & size, paint);
//    context.canvas.drawRect(Rect.fromLTWH(100, 100, 100, 100), paint);
//    context.canvas.drawRect(rect, paint)
//    context.canvas.drawRect(offset, paint);
  }

  DogRenderObject({
    Offset size,
  });

}
