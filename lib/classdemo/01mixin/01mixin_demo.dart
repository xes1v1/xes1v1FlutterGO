void main() {
  /// 学习总结：
  /// 1. mixin 关键字使用
  ///    作用：复用相同超类的非静态的 方法，属性，  达到代码复用的特点。
  ///
  ///    使用方式 关键字顺序  extends => with => implements
  ///    class Dog extends Animal with Person implements Fly {}
  ///
  ///    mixin 修饰的类有几个限制
  ///    1）类不允许有构造方法
  ///    2）class 修饰的类如果想要通过with使用mixin特性，则必须是继承object的对象
  ///    3）进行mixin的类他们必须有同一个Superclass
  ///    4）mixin 修饰的类可以使用 on 关键字来进行继承操作
  ///
  ///    mixin 可扩展性
  ///    由于mixin在dart语言中实现时使用的是class概念，并且是通过继承链来完成代码的复用
  ///    所以他遵循类，接口的扩展
  ///
  /// 2. 核心理解点：
  ///    mixin 的实现方式，理解 继承链 和 顺序
  ///
  /// 3. 与extends的区别
  ///    1）extends 方法必须有依赖顺序，  mixin本身没有
  ///    2）extends 的类型只与直接直系关系有关  ， mixin 满足 extends , with ， implements 的所有类型
  ///    3）mixin的实现方式将减少无用的由于extends或者implements所产生的无用代码
  ///    4）dart中实现mixin概念使用的是extends的方式，但两者的设计理念完全不是一回事
  ///
  /// 4. 注意点
  ///    1）通过mixin想要达到约束使用顺序的能力，必须要遵循mixin的继承链顺序
  ///    2）mixin使用的前提是统一超类
  ///
  /// 5. 什么情况下会使用它
  ///    1）如果遇到需要继承多个父类达到使用方法的目的， 此时可以使用 mixin
  ///    2）当代码复用的情况不适合使用 继承，工具类的时候也可以考虑使用mixin
  ///    3）自己想象吧
  ///
  /// 6. flutter中的典型使用
  ///    widget 的父类 DiagnosticableTree
  ///    class WidgetsFlutterBinding extends BindingBase with GestureBinding, ServicesBinding, SchedulerBinding, PaintingBinding, SemanticsBinding, RendererBinding, WidgetsBinding
  ///
  ///
  ///

//  Dog dog = new Dog();
////  dog.eat();
//  dog.thinking();
////  dog.a();
////  dog.b();
//
////  print(dog is Dog);
////  print(dog is Person);

  PA pa = new PA();
  pa.thinking();
// PB pb = new PB();
// pb.thinking();
//
//  PC pc = new PC();
//  print(pc.a);
//  print(A.b);
//  pc.thinking();
//   pc.eat();
}

//class Dog {
//  void thinking() {
//    print("dog thinking");
//  }
//}

//abstract class C {
//  void eat();
//}
//
//abstract class D {
//  void d();
//}


class Person {
  void thinking() {
    print("person thinking");
  }
}

mixin A on Person {
//  static String b = "testa";
//  String a = "test";
  void thinking() {
//    super.thinking();
    print("A thinking");
  }
}

mixin B on Person {
  void thinking() {
    super.thinking();
    print("B thinking");
  }
}

//class PC extends Person with A {}
//
class PA extends Person with A, B, A {}
//class PB extends Person with B, A {}

//class PA  with Dog, Person {}

//abstract class Animal {
//  void eat();
//}

//class Dog with Person, A, B {
////  @override
////  void eat() {
////    print("dog eat");
////  }
//
//}
