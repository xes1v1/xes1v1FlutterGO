import 'package:flutter/material.dart';
import 'package:flutter_app/classdemo/widgets/02CustomizeWidget.dart';

void main() => runApp(DogApp());

class DogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "dog demo",
      home: Scaffold(
        appBar: AppBar(
          title: Text("text"),
        ),
        body: Center(
           child: Column(
             mainAxisSize: MainAxisSize.max,
             children: [
               DogWidget(),
             ]
           ),
//          child: DogWidget(),
        ),
      ),
    );
  }
}
