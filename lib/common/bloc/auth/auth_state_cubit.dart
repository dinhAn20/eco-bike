import 'package:eco_bike/common/bloc/auth/auth_state.dart';
import 'package:eco_bike/features/auth/domain/usecases/is_logged_in.dart';
import 'package:eco_bike/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  Future<void> appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
