/*
 * Created with Android Studio.
 * User: wangshuai
 * Date: 2019-11-06
 * Time: 19:36
 * tartget: TODO 添加本文件描述信息
 */
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
    super.say();
  }
}

mixin C on Base {
  void say() {
    print("c");
    super.say();
  }
}

// todo 改造你认为需要改造的类 满足 main 方法输出的要求
class PrintSay extends Base with A,B,C {

}

void main() {
  // todo 修改以上代码，输出 c b a 的顺序
  PrintSay().say();
}
