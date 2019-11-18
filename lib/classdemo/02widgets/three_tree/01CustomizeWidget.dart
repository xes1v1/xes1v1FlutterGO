import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// ================================================
/// ================================================
///
/// widget-element关键流程图
/// https://www.processon.com/view/link/5da988a3e4b0e43392eca896
///
/// ================================================
/// ================================================

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
///     WidgetsFlutterBinding.ensureInitialized()
///    ..attachRootWidget(app)  // widgetsBinging
///    ..scheduleWarmUpFrame(); // ScheduleBinding
///
///         BuildOwner       PipelineOwner
///            |  初始化调整      |  纯渲染   -----  {rendersStack, repaintBoundary, PhysicalModelLayer}
///    widget - element - renderobject（创建绘制）
///    遗留问题：
///    1. 正常创建绘制过程中， 子超过了父的约束父会做什么？
///    2. 绘制完毕后， setstate() 时如何来进行调整的。
///
///
///
///
///   1. 正常创建绘制过程中， 子超过了父的约束父会做什么？
///
///   在renderObject的 layout()阶段，根据  sizedByParent 这属性去判断是否需要重新计算size，
///   if (sizedByParent) {
///     performResize();
///   }
///   sizedByParent 是一个get获取的，默认为false，在需要的子类直接会返回true，也就是说flutter定义了不同的子类的职能
///   当特定类型子类的sizedByParent返回了true，它就会去重新计算size，而不是根据子类有没有超出父类的约束去判断需不需要
///   重新计算。在子类的performResize()里面会进行size的计算。
///
///   关于layout的遍历，在整个layout过程中，只会遍历一次。但是在遍历的过程中，自上(parent)而下(child)的传递约束信息(constraints)，自下(child)而上(parent)的传递几何信息(size)。
///   layout阶段会调取各自子类的performLayout()去计算自身的size
///
///
///   2. 绘制完毕后， setState() 时如何来进行调整的。
///
///   在statefulWidget调用setState()时，会调用markNeedsBuild()，在markNeedsBuild()里面把当前的element设置为dirty，
///   然后调用buildOwner的scheduleBuildFor()，在这里把当前的element添加到_dirtyElements里面去，当下一个Vsync信号到来时，调用WidgetsBinding的drawFrame()
///   在WidgetsBinding的drawFrame()的 buildOwner.buildScope()里面调取 Element的rebuild  然后调取componentElement的performRebuild()，然后在走build --> updateChild
///   完了之后进入RendererBinding的drawFrame()然后依次走重新布局的阶段，大致的流程如下
///
///   【StatefulWidget】setState() ---> 【Element】markNeedsBuild() element.dirty = true ---> 【BuildOwner】scheduleBuildFor(this) _dirtyElements.add(element)
///   ---> 【WidgetsBinding】drawFrame() ---> 【BuildOwner】buildScope() ---> 【Element】rebuild() ---> 【ComponentElement】performRebuild()
///   ---> build() ---> updateChild() ---> 【RendererBinding】drawFrame() ---> pipelineOwner.flushLayout() ....
///
///
///
///
///

class DogWidget extends RenderObjectWidget {

  final Color color ;
  final double width;
  final double height;

  @override
  RenderObjectElement createElement() {
    return DogElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    /// 创建容器里需要的绘制内容
    return DogRenderObject(this.color, this.width, this.height);
  }

  DogWidget({this.color = Colors.amber, this.width = 10, this.height = 10});

}

class TitleElement extends RenderObjectElement {
  String title;

  TitleElement(DogWidget widget, this.title) : super(widget);

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

  DogElement(DogWidget widget, {this.child}) : super(widget);

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

class DogRenderObject extends RenderProxyBox {

  Color color;
  double width;
  double height;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    var paint =  Paint();
    paint.color = color;
    var size = Size(width, height);
    context.canvas.drawRect(offset & size, paint);
  }

  DogRenderObject(this.color, this.width, this.height);
}
