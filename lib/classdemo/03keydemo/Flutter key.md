#### Flutter key

##### key
新创建一个Flutter Application的时候，默认生成的代码里面有这么一段
```dart
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
```
title很好理解，给AppBar传参使用的，那么另一个参数key是做干什么的呐？

带着这个疑问先看几个小例子：
首先写个小demo作为调试的入口
```dart
class DemoKeys extends StatefulWidget {
  DemoKeys({Key key}) : super(key: key);

  @override
  _DemoKeyState createState() => _DemoKeyState();
}

class _DemoKeyState extends State<DemoKeys> {
  List<Widget> widgets = [
    StatelessContainer(),
    StatelessContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchWidget,
        child: Icon(Icons.swap_horizontal_circle),
      ),
    );
  }

  switchWidget() {
    widgets.insert(0, widgets.removeAt(1));
    setState(() {});
  }
}
```
小demo很简单，屏幕的中间添加两个widget，下方一个按钮，点击按钮，交换两个widget。

##### 场景一：stateless
```dart
class StatelessContainer extends StatelessWidget {
  final Color color = randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
```
首先使用两个StatelessWidget进行测试，点击下方按钮，两个方块进行了交换。

![stateless](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/stateless.gif)

##### 场景二：stateful without key
```dart
class StatefulContainer extends StatefulWidget {
  StatefulContainer({Key key}) : super(key: key);
  @override
  _StatefulContainerState createState() => _StatefulContainerState();
}

class _StatefulContainerState extends State<StatefulContainer> {
  final Color color = randomColor();

  @override
  Widget build(BuildContext context) {
    print('StatefulContainerState build');
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
```
当我们把`List<Widget> widgets`中的`StatelessContainer`换成`StatefulContainer`之后，即
```dart
List<Widget> widgets = [
  StatelessContainer(),
  StatelessContainer(),
];
```
再点击按钮，会发现没有任何变化，这是为什么呐？

![stateless](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/statefulWithoutKey.gif)

稍安勿躁，再看第三个场景

##### 场景三：stateful with key
还是用上面的`StatefulContainer`，在`List<Widget> widgets`中添加上`key`，即
```dart
List<Widget> widgets = [
    StatefulContainer(
      key: UniqueKey(),
    ),
    StatefulContainer(
      key: UniqueKey(),
    )
  ];
```
再次点击按钮发现两个方块又能交换了。

![stateless](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/statefulWithKey.gif)

##### widget的更新机制
先说几个概念吧，咱们平时编写的Flutter UI 代码操的都是 `widget tree`，除了这棵树，flutter 还有`element tree`和`rendObject tree`，其中widget是不可变的，是用来描述element，当widget进行改变的时候，会重新创建新的widget，这时候element不一定会重新创建。

widget的源码里面，有这样一个方法：
```dart
@immutable
abstract class Widget extends DiagnosticableTree {
  const Widget({ this.key });
  final Key key;
  ···
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}
```
通过这个方法去判断，`newWidget`是否可以更新`oldWidget`对应的element。如果可以更新，则`element`还是使用`oldWidget`对应的element，只是使用新创建的widget对这个element进行更新。

这样也就解释了场景一只使用stateless widget时发生交换，两个widget的runtimeType一致，又没有传key，canUpdate返回true，这时候将element更新为对应的颜色。

![stateless](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/stateless.png)

至于场景二，同样由于没有传key，只做runtimeType比较，更新element，但为啥不变颜色呐。这个问题要从stateful本身说起，大家知道stateful是有state来管理其状态改变。element和state一一对应，下面是官方的解释。
```dart
/// The [State] instance associated with this location in the tree.
/// There is a one-to-one relationship between [State] objects and the
/// [StatefulElement] objects that hold them. The [State] objects are created
/// by [StatefulElement] in [mount].
```
在statefulContainer中的颜色是定义在state中的，虽然交换了widget，但是其element及对应的state并没有发生改变，所以方块看起来没有任何变化。

![无key交换](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/无key交换.png)

对于场景三由于加上key之后canUpdate返回false（runtimeType 相同，key 不同），不能再更新element，这时候旧的`widget`和`element`的关联关系发生了改变

![不匹配移除](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/不匹配移除.png)

此时 RenderObjectElement 会用新 Widget 的 key 在老 Element 列表里面查找，找到匹配的则会更新 Element 的位置并更新对应 renderObject 的位置,所以颜色发生了变化。

![查找](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/查找.png)

##### 比较范围

对widget的更新机制有一定了解后，咱们看最后一个例子吧。
```dart
List<Widget> widgets = [
    Padding(
//      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatefulContainer(
        key: UniqueKey(),
      ),
    ),
    Padding(
//      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatefulContainer(
        key: UniqueKey(),
      ),
    ),
  ];
```
在场景三：stateful with key的widget之上包一层padding，这时候点击按钮你将会看到，每次颜色都会发生变化

![padding](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/padding.gif)

这是由于Flutter的比较算法（diff）是有范围的，它是对特定层级进行比较，

![padding](https://raw.githubusercontent.com/whqfor/sources/master/blog/Key/paddinng.png)

这里首先比较padding，其runtimeType一致，所以交换两个widget时，只会更新其element，然后再比较下一个层级，在这个`层级`并不能找到一个和自己相同的key valu，所以会创建一个新的。之前stateful 两个节点都在一个row 节点内，属于同一个层级，所以虽然交换了之后，在同一个层级内能找到相同key的element，因此并不会创建新的element。
statefulContainery每次都是重新创建的，所以每次看到的效果是一直在变化颜色。
将最后一个场景注释掉的代码打开，即给padding也加一个key，这种情况就和场景三是一样的，key对应不上，移除匹配关系，然后在同一层级重新查找，更新widget和element对应关系。

##### Key种类
经过以上讲解，想必对key的作用也有了一定的了解，它能用于帮助我们保存widget的状态。上面咱们使用了UniqueKey()
，如果再好奇一点，点进Key的文档中看看，你会发现Key主要有两大种类`LocalKey`和`GlobalKey`，使用的所有key的子类都应该继承这两个类。

`LocalKey`的子类有`ValueKey`、`ObjectKey`、`UniqueKey`、`PageStorageKey`
`GlobalKey`的子类有`LabeledGlobalKey`、`GlobalObjectKey`
那么什么情况下该使用哪种key呐？

`ValueKey`：
官方视频举例是，当你有一个TODO List列表，每完成一个任务，就把这个列表删除的时候可以使用valuekey，因为列表上的text是个value，一个value即可标识出唯一性。
`ObjectKey`：
一个班级里可能有重名的学生，想要标识每一个学生再使用valuekey可能不太合适，不过每个学生还有一些其他信息，比如生日、年龄家庭住址等，信息更复杂，或许其中的单个项有重复，但是当他们组合在一起时，就能够唯一标示每一个学生了，这时候使用ObjectKey是个不错的选择。
`UniqueKey`
如果需要更进一步确保，每个widget是唯一的，可以使用UniqueKey，demo中使用的也是UniqueKey。但是有种情况需要考虑，每次widget有改变的时候会生成新的UniqueKey，这样之前的key就丢失了，失去了一致性，每次都会重新创建element，那这种情况还不如不使用。
`PageStorageKey`
当你有一个滑动列表，你通过某一个 Item 跳转到了一个新的页面，当你返回之前的列表页面时，你发现滑动的距离回到了顶部。这时候，给 Sliver 一个 PageStorageKey！它将能够保持 Sliver 的滚动状态。

`GlobalKey`
GlobalKey是全局的，可以保存widget中任何地方使用，而不用担心状态丢失等，也可以用来传递widget中的信息，不过方便带来的是更大的开销，它维护一个全局的Map来标识GlobalKey与之对应的Element。
`LabeledGlobalKey`
用来debugging调试，标识GlobalKey的信息。
`GlobalObjectKey`
经常用来绑定一个widget和生辰这个widget的object。

最后补充一点，在测试场景二的时候，交换了widget，虽然两个widget的描述信息完全一样，并且element也没有重新创建，但是build每次都会执行，我的理解是，widget和element的对应关系发生了改变，因此会重新执行build。具体还需要看updatechild 里面的执行是怎么触发了widget build。

##### 参考文章
[Flutter|深入浅出Key](https://juejin.im/post/5ca2152f6fb9a05e1a7a9a26#heading-13)
[何时使用密钥 - Flutter小部件 101 第四集](https://www.youtube.com/watch?v=kn0EOS-ZiIc)




