class Base {
  void say() {
    print("a");
  }
}

mixin A on Base {
  void say() {
    print("a");
  }
}

mixin B on Base {
  void say() {
    print("b");
  }
}

mixin C on Base {
  void say() {
    print("c");
  }
}

// todo 改造它让他能够成为 main 方法满足输出要求的类
class PrintSay {
  void say() {}
}

void main() {
  //todo 修改以上代码，输出 c b a 的顺序
  PrintSay().say();
}
