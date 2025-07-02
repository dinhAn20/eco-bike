import 'package:eco_bike/common/bloc/auth%20/auth_state.dart';
import 'package:eco_bike/common/bloc/auth%20/auth_state_cubit.dart';
import 'package:eco_bike/features/app/home/pages/home.dart';
import 'package:eco_bike/features/auth/presentation/pages/signin.dart';
import 'package:eco_bike/injection_container.dart';
import 'package:eco_bike/services/brightness_service.dart';
import 'package:eco_bike/services/device_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const routeName = '/splash';
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double brightness = 1;
  @override
  void initState() {
    super.initState();
    BrightnessService.setBrightness(brightness);
    // Future.delayed(Duration.zero, () {
    //   sl<AuthStateCubit>().appStarted();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final info = await DeviceService.getDeviceInfo();
              print("Thiết bị: ${info['brand'] ?? info['name']}");
              print("Model: ${info['model']}");
              print(
                "OS: ${info['systemName'] ?? 'Android'} ${info['version'] ?? info['systemVersion']}",
              );
            },
            child: const Text("Lấy thông tin thiết bị"),
          ),
          Slider(
            min: 0.0,
            max: 1.0,
            divisions: 20,
            value: brightness,
            onChanged: (val) {
              setState(() => brightness = val);
              BrightnessService.setBrightness(val);
            },
          ),
        ],
      ),
    );
    return BlocListener<AuthStateCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.routeName,
            (route) => false,
          );
        } else if (state is UnAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SigninPage.routeName,
            (route) => false,
          );
        }
      },
      // listenWhen: (previous, current) => previous != current,
      child: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
