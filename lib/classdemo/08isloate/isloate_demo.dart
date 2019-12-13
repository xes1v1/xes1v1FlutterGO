import 'dart:core' ;
import 'dart:isolate';

///
/// Flutter的线程 ： https://flutter.dev/docs/perf/rendering/ui-performance
///
/// dart中通过debug ， isolate的创建会产生一个新的thread，这个thread 是否是真是的平台的thread的
/// 还需要继续debug源码内容。
///
/// 需要了解的一些知识点：
/// 1. dart 代码会运行在一个 zone 管理的内容中 zone 又是什么？
/// 2. 注解： entry point 这个知识点需要具体了解一下
///
/// 12月13日得出结论：
/// 通过dart vm Observatory 可以看到
/// isolate 通过 [Isolate.spawn(entryPoint, message)] 方法创建的isolate
///
///
void main() async {

//  main isolate = thread
//
//  1isolate = thread  {main , cure}
//
//  print(await compute(syncFibonacci, 20));
  int a = await asyncFactoriali(10);
//  print(a);
//  print(createIsolate());

}

Isolate createIsolate() {
  SendIsolatePort sendPort = SendIsolatePort();
  RecevcedIsolateSend recvPort = RecevcedIsolateSend();
  Isolate isolate1 = Isolate(sendPort);
  sendPort.send(recvPort);
  return isolate1;
}

class RecevcedIsolateSend extends SendPort {

  @override
  void send(message) {
    print(message);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other &&
              other is RecevcedIsolateSend &&
              runtimeType == other.runtimeType;

  @override
  int get hashCode =>
      super.hashCode;

}

class SendIsolatePort extends SendPort {

  @override
  void send(message) {
    while(true) {
      print("a");
    }
//    print(message);
  }

  @override
  int get hashCode {
    return super.hashCode;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          super == other &&
              other is SendIsolatePort &&
              runtimeType == other.runtimeType;

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
//  Isolate isolate2 = await Isolate.spawn(_isolate, response.sendPort);
//  Isolate isolate3 = await Isolate.spawn(_isolate, response.sendPort);
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
//  isolate?.kill(priority: Isolate.immediate);
//  isolate = null;
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
  n = 30;
//  print(Isolate.current);
  return n < 2 ? n : syncFibonacci(n - 2) + syncFibonacci(n - 1);
}