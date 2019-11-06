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
  @override
  void eat() {
    print("Fish");
  }
  void swim() {
    print("Fish swim");
  }
}


class Swan extends Animal with Bird , Fish {
  @override
  void eat() {
    super.eat();
  }
}

void main() {
  Swan swan = Swan();
  swan.eat();
}
