/*
 * Created with Android Studio.
 * User: sunjian
 * Date: 2019-12-07
 * Time: 11:31
 * target: TODO 添加本文件描述信息
 */
import 'package:flutter/material.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/SJ_CustomizeChildWidget.dart';

import 'classdemo/02widgets/three_tree/sj_custom_widget.dart';

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
    return Center(
//      child: Container(
//        color: Colors.limeAccent,
//        height: 200,
//        width: 200,
      child: SjCustomWidget(
          color: Colors.blueGrey,
          height: 200,
          width: 200,
          child:
//            Text(
//              "乌卡卡乌卡卡乌卡卡乌卡卡乌卡卡乌卡卡乌卡卡乌卡卡乌卡卡",
//              style: TextStyle(color: Colors.white, fontSize: 22),
//              textDirection: TextDirection.ltr,
//            )
              SjCustomChildWidget(
            width: 100,
            height: 100,
          )),
//      ),
    );
  }
}
