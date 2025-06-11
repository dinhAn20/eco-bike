import 'package:eco_bike/common/bloc/auth%20/auth_state.dart';
import 'package:eco_bike/common/bloc/auth%20/auth_state_cubit.dart';
import 'package:eco_bike/features/app/home/pages/home.dart';
import 'package:eco_bike/features/auth/presentation/pages/signin.dart';
import 'package:eco_bike/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  static const routeName = '/splash';
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      sl<AuthStateCubit>().appStarted();
    });
  }

  @override
  Widget build(BuildContext context) {
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
