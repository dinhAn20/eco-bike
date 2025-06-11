import 'package:eco_bike/common/bloc/button%20/button_state.dart';
import 'package:eco_bike/common/bloc/button%20/button_state_cubit.dart';
import 'package:eco_bike/common/widgets/button%20/basic_app_button.dart';
import 'package:eco_bike/features/app/home/bloc/user_display_cubit.dart';
import 'package:eco_bike/features/app/home/bloc/user_display_state.dart';
import 'package:eco_bike/features/auth/domain/entities/user.dart';
import 'package:eco_bike/features/auth/domain/usecases/logout.dart';
import 'package:eco_bike/features/auth/presentation/pages/signup.dart';
import 'package:eco_bike/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonStateCubit()),
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            }
          },
          child: Center(
            child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is UserLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _username(state.userEntity),
                      const SizedBox(height: 10),
                      _email(state.userEntity),
                      _logout(context),
                    ],
                  );
                }
                if (state is LoadUserFailure) {
                  return Text(state.errorMessage);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _username(UserEntity user) {
    return Text(
      user.username,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _email(UserEntity user) {
    return Text(
      user.email,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _logout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: BasicAppButton(
        title: 'Logout',
        onPressed: () {
          context.read<ButtonStateCubit>().excute(usecase: sl<LogoutUseCase>());
        },
      ),
    );
  }
}
