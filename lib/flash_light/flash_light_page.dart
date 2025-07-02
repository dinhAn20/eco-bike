import 'package:eco_bike/features/core/common/common.dart';
import 'package:eco_bike/flash_light/flash_light_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlashLightPage extends StatefulWidget {
  static const routeName = '/flash';
  const FlashLightPage({super.key});

  @override
  State<FlashLightPage> createState() => _FlashLightPageState();
}

class _FlashLightPageState extends State<FlashLightPage> {
  bool isOn = false;

  Future<void> toggleFlashlight() async {
    try {
      if (isOn) {
        await FlashLightService.turnOff();
      } else {
        await FlashLightService.turnOn();
      }
      setState(() {
        isOn = !isOn;
      });
    } on PlatformException catch (e) {
      toast(e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isOn ? Colors.black : Colors.white,
      body: Center(
        child: GestureDetector(
          onTap: toggleFlashlight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isOn ? Icons.flashlight_on : Icons.flashlight_off,
                size: 120,
                color: isOn ? Colors.yellow : Colors.grey,
              ),
              const SizedBox(height: 12),
              Text(
                isOn ? "Đèn đang bật" : "Đèn đang tắt",
                style: TextStyle(
                  color: isOn ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
