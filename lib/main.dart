import 'package:flutter/material.dart';
import 'package:flutter_app/classdemo/02widgets/gesture/GestureWidget.dart';

void main() => runApp(DogApp());

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
    return GestureWidget(
      color: Colors.lightBlue,
      width: 100,
      height: 100,
      onTap: () {
        print("haah");
      },
    );
  }
}
