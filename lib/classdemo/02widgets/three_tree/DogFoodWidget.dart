import 'package:flutter/material.dart';

class DogFoodWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}

class DogScaffold extends StatefulWidget {

  final Color bg;

  final Widget _dogHeadWidget;
  final Widget _dogBodyWidget;
  final Widget _dogFoodWidget;


  DogScaffold(this.bg , this._dogHeadWidget, this._dogBodyWidget,
      this._dogFoodWidget);

  @override
  State<StatefulWidget> createState() {
    return _DogScaffoldState(
        _dogHeadWidget,
        _dogBodyWidget,
        _dogFoodWidget,
       this.bg
    );
  }
}

/// dog scaffold state
class _DogScaffoldState extends State {

  Widget _dogHeadWidget;
  Widget _dogBodyWidget;
  Widget _dogFoodWidget;
  Color  _color;

  _DogScaffoldState(this._dogHeadWidget, this._dogBodyWidget,
      this._dogFoodWidget, this._color): assert(_dogFoodWidget != null),
        assert(_dogFoodWidget != null);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
