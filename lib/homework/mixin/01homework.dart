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

class PrintSay extends Base with A, B, C {}

void main() {
  //todo 修改以上代码，输出 c b a 的顺序
  PrintSay().say();
}
