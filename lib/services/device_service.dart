import 'package:eco_bike/features/core/common/common.dart';
import 'package:flutter/services.dart';

class DeviceService {
  static const _channel = MethodChannel('com.example.eco_bike/screen');

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final result = await _channel.invokeMethod<Map>('getDeviceInfo');
      return Map<String, dynamic>.from(result ?? {});
    } on PlatformException catch (e) {
      toast("Error: ${e.message}");
      return {};
    }
  }
}
