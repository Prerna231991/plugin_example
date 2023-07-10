
import 'dart:async';
import 'package:flutter/services.dart';
class SharedAndroidIos {
  static const MethodChannel methodChannel = MethodChannel("shared_android_ios");
  Future<void> share(String message) async{
    await methodChannel.invokeMethod("share",{"message":message});
  }
}
