import 'package:eco_bike/common/bloc/auth%20/auth_state_cubit.dart';
import 'package:eco_bike/features/auth/data/repository/auth.dart';
import 'package:eco_bike/features/auth/data/source/auth_api_service.dart';
import 'package:eco_bike/features/auth/data/source/auth_local_service.dart';
import 'package:eco_bike/features/auth/domain/repository/auth_repository.dart';
import 'package:eco_bike/features/auth/domain/usecases/get_user.dart';
import 'package:eco_bike/features/auth/domain/usecases/is_logged_in.dart';
import 'package:eco_bike/features/auth/domain/usecases/logout.dart';
import 'package:eco_bike/features/auth/domain/usecases/signin.dart';
import 'package:eco_bike/features/auth/domain/usecases/signup.dart';
import 'package:eco_bike/injection_container.dart';

Future<void> authInjectionContainer() async {
  // Bloc or Cubit
  sl.registerSingleton<AuthStateCubit>(AuthStateCubit());

  // Services
  sl.registerSingleton<AuthApiService>(
    AuthApiServiceImpl(dioClient: sl.call()),
  );
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl(sl.call()));

  // Repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(sl.call(), sl.call()),
  );

  // Usecases
  sl.registerLazySingleton<SignupUseCase>(() => SignupUseCase());
  sl.registerLazySingleton<SigninUseCase>(() => SigninUseCase());
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase());
  sl.registerLazySingleton<IsLoggedInUseCase>(() => IsLoggedInUseCase());
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase());
}
