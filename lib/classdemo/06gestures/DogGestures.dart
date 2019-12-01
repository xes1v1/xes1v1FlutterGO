import 'package:flutter/material.dart';
import 'package:flutter_app/classdemo/02widgets/three_tree/01CustomizeWidget.dart';

void main() => runApp(DogApp());
///  点击按钮
///
class DogApp extends StatefulWidget {
  @override
  _DogAppState createState() => _DogAppState();
}

class _DogAppState extends State<DogApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center (
            child: GestureDetector (
              child: DogWidget(width: 100, height: 100,),
              onTap: () {
                print("on tAP !!!!");
              },
            ) 
        )
    );
      
      
//      GestureDetector(
//      onTap: () {
//        print("on Tap !!!");
//      },
//      child: Container(
//        child: Center (
//          child: DogWidget(width: 100, height: 100,)
//        )
//      )
//    );
  }
}
