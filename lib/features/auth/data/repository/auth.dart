import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eco_bike/features/auth/data/models/signin_req_params.dart';
import 'package:eco_bike/features/auth/data/models/signup_req_params.dart';
import 'package:eco_bike/features/auth/data/models/user.dart';
import 'package:eco_bike/features/auth/data/source/auth_api_service.dart';
import 'package:eco_bike/features/auth/data/source/auth_local_service.dart';
import 'package:eco_bike/features/auth/domain/repository/auth_repository.dart';
import 'package:eco_bike/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _apiService;
  final AuthLocalService _localService;

  AuthRepositoryImpl(this._apiService, this._localService);
  @override
  Future<Either> getUser() async {
    var result = await _apiService.getUser();
    return result.fold((error) => Left(error), (data) {
      Response response = data;
      var userModel = UserModel.fromMap(response.data);
      var userEntity = userModel.toEntity();
      return Right(userEntity);
    });
  }

  @override
  Future<bool> isLoggedIn() {
    return _localService.isLoggedIn();
  }

  @override
  Future<Either> logout() {
    return _localService.logout();
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    var result = await _apiService.signin(signinReq);
    return result.fold((error) => Left(error), (data) {
      Response response = data;
      sl<SharedPreferences>().setString('token', response.data['token']);
      return Right(response);
    });
  }

  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    var result = await _apiService.signup(signupReq);
    return result.fold((error) => Left(error), (data) {
      Response response = data;
      sl<SharedPreferences>().setString('token', response.data['token']);
      return Right(response);
    });
  }
}
