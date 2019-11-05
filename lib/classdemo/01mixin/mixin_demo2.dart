import 'package:flutter_app/classdemo/01mixin/01mixin_demo.dart';

abstract class Animal {
  void eat() {
    print("animal eat");
  }
}

class Bird  {
  void fly() {
    print("bird fly");
  }
}

mixin Fish on Animal {
  void swim() {
    print("Fish swim");
  }
}

mixin SpecialEat on Animal {
  @override
  void eat() {
    super.eat();

  }
}


class Swan extends Animal with Bird , Fish, SpecialEat { }

void main() {
  Swan swan = Swan();
  swan.eat();
}
