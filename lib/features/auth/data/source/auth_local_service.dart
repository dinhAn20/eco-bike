import 'package:dartz/dartz.dart';
import 'package:eco_bike/features/core/keychain/shared_prefs.dart';
import 'package:eco_bike/features/core/keychain/shared_prefs_key.dart';

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<Either> logout();
}

class AuthLocalServiceImpl extends AuthLocalService {
  final SharedPrefs _sharedPrefs;

  AuthLocalServiceImpl(this._sharedPrefs);

  @override
  Future<bool> isLoggedIn() async {
    var token = _sharedPrefs.get<String>(SharedPrefsKey.token);
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Either> logout() async {
    _sharedPrefs.clear();
    return const Right(true);
  }
}
