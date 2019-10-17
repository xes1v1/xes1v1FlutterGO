
/// StatelessWidget:
/// 概念：一旦创建就不关心任何变化
/// 只有在 loaded/built 时才会绘制一次，这意味着任何事件或用户操作都无法对该 Widget 进行重绘
///
/// 例如：Text、Row、Column 和 Container、Stack都属于Stateless Widget，这些Widget的参数一旦配置了，在下次构建过程之前都不会改变。
///
///
/// 生命周期：
/// 初始化 -- > build渲染


/// StatefulWidget:
/// 内部持有的数据在其生命周期内可能会发生变化的Widget，这些会变化的数据，叫State
///
///
/// 生命周期：
///  1、initState()：在这个State对象的生命周期内，只会执行一次。此时的context和State对象还没有关联起来，重写该方法时，首先调用super.initState()。
///  2、didChangeDependencies()：此时的context和State对象已关联，重写该方法，首先调用super.didChangeDependencies()。
///  3、build(BuildContext context)
///  4、dispose()：重写该方法，先执行需要销毁的方法，最后在调用super.dispose()
///
///
/// StatefulWidget由两部分组成
///


/// 什么时候用StatelessWidget、什么时候用StatefulWidget:
/// 总结一句话：需要调用setState()的Widget用StatefulWidget，否则使用StatelessWidget
///



/// Widget生命周期探究
/// 1、void main() => runApp(MyApp()); 创建WidgetsBinding，并开始执行
/// 2、执行WidgetsBinding的 void attachRootWidget(Widget rootWidget)
/// 3、执行RenderObjectToWidgetAdapter的attachToRenderTree(buildOwner, renderViewElement)
/// 4、调取对应element子类的 element = createElement();
/// 5、调取对应element子类的 element.mount(null, null);，
/// 并且会最终调用 Element的mount()，在element的mount里面，
/// 会调用GlobalKey的_register去添加Key到Map<GlobalKey, Element> _registry = <GlobalKey, Element>{};
/// 同时也会把inheritedWidget保存到Map<Type, InheritedElement> _inheritedWidgets;
/// 6、如果是StatefulElement、StatelessElement，会调取自身的element.mount(),
/// 在这个函数里面，会调用_StatefulElement的_firstBuild(),
/// 在这个函数里面，会调用i_state.initState()，紧接着会调用_state.didChangeDependencies()，
/// 在最后面会调用super._firstBuild();
/// 这时候就回到了ComponentElement的_firstBuild()，在ComponentElement的_firstBuild()里面调用rebuild()，
/// 在rebuild()调用performRebuild()，然后在performRebuild()调用build()，这个build()就是我们熟悉的build了。
/// 7、在对应类element子类的mount里面，有的会调取_rebuild();
/// 在_rebuild()里面调用最关键的函数Element updateChild(Element child, Widget newWidget, dynamic newSlot),
/// 在这函数里面，符合条件时会调用void deactivateChild(Element child)，在这里最终会调用child.deactivate()



import 'package:flutter/material.dart';

class TestStatefulWidget extends StatefulWidget {

  /// StatefulWidget的第一部分
  /// 该部分是public的，在其生命周期内，都不会发生变化
  /// 如下面的name，通常在其生命周期内不会发生变化。

  final String name;

  TestStatefulWidget({Key key, this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TestStatefulWidget();
  }
}

class _TestStatefulWidget extends State<TestStatefulWidget> {

  /// StatefulWidget的第二部分
  /// 该部分通常是private的（推荐），也可以是public的
  /// 作用：管理TestStatefulWidget在其生命周期内的所有变化


  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }

  @override
  void dispose() {

    /// 在这里写相关的清除操作，最后调用super.dispose();

    // test.dispose()

    super.dispose();
  }
}
