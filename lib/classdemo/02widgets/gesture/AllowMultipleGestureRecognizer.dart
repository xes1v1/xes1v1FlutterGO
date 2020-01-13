/*
 * Created with Android Studio.
 * User: sunjian
 * Date: 2020-01-02
 * Time: 15:03
 * target: TODO 添加本文件描述信息
 */
import 'package:flutter/gestures.dart';

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
