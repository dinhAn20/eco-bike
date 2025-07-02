import 'package:flutter/services.dart';

class FlashLightService {
  static const _channel = MethodChannel('com.example.eco_bike/flashlight');

  static Future<void> turnOn() async {
    await _channel.invokeMethod('turnOn');
  }

  static Future<void> turnOff() async {
    await _channel.invokeMethod('turnOff');
  }
}
