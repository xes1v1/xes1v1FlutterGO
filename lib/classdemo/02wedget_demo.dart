import 'package:flutter/material.dart';

class StatelessDemo extends StatelessWidget {
  ///
  /// 大流程
  /// WidgetsFlutterBinding 在 runapp 启动实际与 rootWidget 进行绑定
  ///
  /// Key 和 GlobalKey 对于绘制的影响？
  /// Key 如何生成？
  ///
  /// 问题
  /// 1. flutter UI 的框架结构
  /// 2. Key 的作用
  /// 3. Key 在什么时机下变更
  /// 4. GlobalKey ?
  ///
  /// 5. state 与 widget 是如何相互作用的
  ///    statefulwidget 在创建时创建 state
  ///
  /// super 的使用
  /// state 的buid 方法里面为什么不返回widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '1',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
