import 'package:flutter/material.dart';

import 'classdemo/02widgets/three_tree/01CustomizeWidget.dart';

void main() => runApp(DogApp());

class DogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return DogWidget();
    return MaterialApp(
      title: "dog demo",
      home: Scaffold(
        appBar: AppBar(
          title: Text("text"),
        ),
        body: Center(
//           child: Align(
//             child: Text("测试")
          child: DogWidget(),
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               DogWidget(),
//             ]
        ),
//          child: DogWidget(),
      ),
//      ),
    );
  }
}
