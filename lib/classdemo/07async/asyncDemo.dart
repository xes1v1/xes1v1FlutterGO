import 'dart:async';

// Future 在将来某时获取一个值的方式. 当一个返回Future的函数被调用的时候，做了两件事情：
//   1.函数把自己放入队列和返回一个未完成的Future对象
//   2.之后当值可用时，Future带着值变成完成状态。
// async   异步标记
// await   阻塞标记，等待返回完成，标记函数为Future并接收Future的返回值
//         注：async修饰的函数本身是Future，
//         等待第一个await开始阻塞，并暂停当前Future，等await的Future返回
printDailyNewsDigest() async {
  print('printDailyNewsDigest start');
  String news = await gatherNewsReports();
  print(news);

//  Future.value(() => {}).then(onValue);

//  final server = await HttpServer.bind('127.0.0.1', 8082);
//  await for (HttpRequest request in server) {
//    request.response.write('Hello, world');
//    await request.response.close();
//  }
}

main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}

printWinningLotteryNumbers() {
  print('Winning lotto numbers: [23, 63, 87, 26, 2]');
}

printWeatherForecast() {
  print("Tomorrow's forecast: 70F, sunny.");
}

printBaseballScore() {
  print('Baseball score: Red Sox 10, Yankees 0');
}

const news = '<gathered news goes here>';
Duration oneSecond = const Duration(seconds: 1);
final newsStream = new Stream.periodic(oneSecond, (_) => news);
Future gatherNewsReports() {
  return newsStream.first;
}
