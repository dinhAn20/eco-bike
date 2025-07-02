import 'package:eco_bike/features/core/common/common.dart';
import 'package:flutter/services.dart';

class BrightnessService {
  static const _channel = MethodChannel('com.example.eco_bike/screen');

  static Future<void> setBrightness(double value) async {
    try {
      await _channel.invokeMethod('setBrightness', {
        'value': value.clamp(0.0, 1.0),
      });
    } on PlatformException catch (e) {
      toast(e.message.toString());
    }
  }
}
