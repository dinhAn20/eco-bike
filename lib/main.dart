import 'package:eco_bike/common/bloc/auth%20/auth_state_cubit.dart';
import 'package:eco_bike/features/app/home/pages/splash.dart';
import 'package:eco_bike/features/core/route/app_route.dart';
import 'package:eco_bike/features/core/theme/app_theme.dart';
import 'package:eco_bike/flash_light/flash_light_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => di.sl<AuthStateCubit>())],
      child: MaterialApp(
        title: 'Eco Bike',
        theme: AppTheme.appTheme,
        initialRoute: FlashLightPage.routeName,
        routes: AppRoute.routes,
      ),
    );
  }
}
