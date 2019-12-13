import 'dart:isolate';

void main() {
  Isolate isolate = Isolate(DemoSendPort());
  isolate.ping(DemoSendPort());
}

class DemoSendPort extends SendPort {
  final String string = "demosendport";

  @override
  void send(message) {
    print(message.toString());
  }

  @override
  int get hashCode {
    return string.hashCode;
  }

  @override
  bool operator ==(other) {
    return string == other.toString();
  }
}
