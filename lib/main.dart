import 'package:flutter/material.dart';

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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.lightBlueAccent),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("aaa111"),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
