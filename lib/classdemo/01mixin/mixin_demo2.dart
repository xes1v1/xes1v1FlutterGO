import 'package:flutter_app/classdemo/01mixin/01mixin_demo.dart';

class Animal {

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

class Swan extends Animal with Bird , Fish {}

void main() {
  Swan swan = Swan();
  swan.fly();
  swan.swim();

  print(swan is Bird);
  print(swan is Fish);
  print(swan is Swan);
}
