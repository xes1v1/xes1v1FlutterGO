import 'package:flutter_app/classdemo/01mixin/01mixin_demo.dart';

class Animal {

  void eat() {
    print("animal eat");
  }
}

abstract class Bird  {
  void eat() {
    print("bird eat");
  }
  void fly() {
    print("bird fly");
  }
}

mixin Fish on Animal {
  void swim() {
    print("Fish swim");
  }
  void eat() {
    print("fish eat");
  }
}

class Swan extends Animal with Bird , Fish { }

void main() {
  Swan swan = Swan();
  swan.eat();
}
