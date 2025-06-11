import 'package:eco_bike/features/auth/auth_injection_container.dart';
import 'package:eco_bike/features/core/keychain/shared_prefs.dart';
import 'package:eco_bike/features/core/network/dio_client.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await sl.isReady<SharedPreferences>();
  sl.registerLazySingleton<SharedPrefs>(
    () => SharedPrefs(sl<SharedPreferences>()),
  );
  sl.registerSingleton<DioClient>(DioClient());
  await authInjectionContainer();
}
