import 'dart:isolate';
import 'dart:async';

void main() async {
//  runApp(MyApp());

  //asyncFibonacci函数里会创建一个isolate，并返回运行结果
  print(await asyncFactoriali(20));
//
////  6765
//  print(await compute(syncFibonacci, 20));
}

//这里以计算斐波那契数列为例，返回的值是Future，因为是异步的
Future<dynamic> asyncFactoriali(int n) async {
  //首先创建一个ReceivePort，为什么要创建这个？
  //因为创建isolate所需的参数，必须要有SendPort，SendPort需要ReceivePort来创建
  final response = new ReceivePort(); // 第一个ReceivePort交换双方port端口

  //开始创建isolate,Isolate.spawn函数是isolate.dart里的代码,_isolate是我们自己实现的函数
  //_isolate是创建isolate必须要的参数。
  // void entryPoint(T message), T message
  // Usually the initial [message] contains a [SendPort]
  Isolate isolate = await Isolate.spawn(_isolate, response.sendPort);
  //获取sendPort来发送数据
  final sendPort = await response.first as SendPort;  // initialReplyTo.send(port.sendPort);

  //接收消息的ReceivePort
  final answer = new ReceivePort(); // 第二个ReceivePort接收数据
  //发送数据
  sendPort.send([n, answer.sendPort]);
  //获得数据并返回
  Future result = answer.first;
//  answer.close();  // root isolate 上的port不用关闭
  response.close();  // 创建的isolate 和 port使用完之后关闭
  isolate?.kill(priority: Isolate.immediate);
  isolate = null;
  return result;
}

//创建isolate必须要的参数
void _isolate(SendPort initialReplyTo) async {
  final port = ReceivePort();
//绑定
  initialReplyTo.send(port.sendPort);
//监听
  final message = await port.first as List;
  //获取数据并解析
  final data = message[0] as int;
  final send = message[1] as SendPort;  // answer.sendPort]
  //返回结果
  send.send(syncFibonacci(data));

//  //监听
//  port.listen((message) {
//    //获取数据并解析
//    final data = message[0] as int;
//    final send = message[1] as SendPort;
//    //返回结果
//    send.send(syncFibonacci(data));
//  });
}

// 多线程机制
int syncFibonacci(int n) {
  return n < 2 ? n : syncFibonacci(n - 2) + syncFibonacci(n - 1);
}

//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}

//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    new Future.microtask(() {
//      // 1micro事件
//      // 正常future是event事件
//    });
//
//
////    Future<String> fetchContent() =>
////        Future<String>.delayed(Duration(seconds:2), () => "Hello")
////            .then((x) => "$x world");
////    print(fetchContent());
//
////    Future(() => print('f1'));
////    Future fx = Future(() => null);
////    Future(() => print('f2'))
////        .then((_) {
////            print('f3');
////            scheduleMicrotask(() => print('f4'));})
////        .then((_) => print('f5'));
////    Future(() => print('f6'))
////        .then((_) => Future(() => print('f7')))
////        .then((_) => print('f8'));
////    Future(() => print('f9'));
////    fx.then((_) => print('f10'));
////    scheduleMicrotask(() => print('f11'));
////    print('f12');
//
//
//    print('main #1 of 2');
//    scheduleMicrotask(() => print('microtask #1 of 3'));
//
//    new Future.delayed(
//        new Duration(seconds: 1), () => print('future #1 (delayed)'));
//    // 代码规范
//    new Future(() => print('future #2 of 4'))
//        .then((_) => print('future #2a'))
//        .then((_) {
//          print('future #2b');
//          scheduleMicrotask(() => print('microtask #0 (from future #2b)'));
//          // 不建议写多个功能，一个then里面只写一个独立的顺序执行的功能。不然可读性很差，顺序不清晰
//        })
//        .then((_) => print('future #2c'));
//
//    scheduleMicrotask(() => print('microtask #2 of 3'));
//
//    new Future(() => print('future #3 of 4'))
//        // The => expr syntax is a shorthand for { return expr; }.
//        .then((_) => new Future(() => print('future #3a (a new future)')))
//        .then((_) => print('future #3b'));
//
//    new Future(() => print('future #4 of 4'))
//        .then((_) {
//          new Future(() => print('future #4a'));
//        })
//        .then((_) => print('future #4b'));
//    scheduleMicrotask(() => print('microtask #3 of 3'));
//    print('main #2 of 2');
//
////    Future<String> fetchContent() =>
////        Future<String>.delayed(Duration(seconds:2), () => "Hello")
////            .then((x) => "$x world")
////            .then((x) {
////              print("$x .");
////              return x;
////        });
////
//////    print(fetchContent());
////
////    Future(() async {
////      print(await fetchContent());
////    });
//
//
//    Future(() => print('f1'))
////    .then((_) async => scheduleMicrotask(() => print('f2')))
//        .then((_) async => await Future(() => print('f2')))
//        .then((_) => print('f3'));
//    Future(() => print('f4'));
//
////    func() async => print(await fetchContent());
////    // await与async只对当前调⽤用上下⽂的函数有效
////    print('start');
////    func();
////    print('end');
//
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many timesss:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
