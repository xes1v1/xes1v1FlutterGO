/*
 * Created with Android Studio.
 * User: sunjian
 * Date: 2019-12-01
 * Time: 22:54
 * target: TODO 添加本文件描述信息
 */

void getData() async {
  print("ttt");
  var f = await t1();
  print("yyyyyy === $f");
  print("ffff");
}

Future<int> t1() {
  return new Future(() {
    for (int i = 0; i < 10; i++) {
      print("$i");
    }
    return 11;
  });
}
