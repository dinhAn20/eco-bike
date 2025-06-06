import 'package:dartz/dartz.dart';
import 'package:eco_bike/features/auth/data/models/signin_req_params.dart';
import 'package:eco_bike/features/auth/data/models/signup_req_params.dart';
import 'package:eco_bike/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<Either> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(SignupReqParams signupReq) {
    // TODO: implement signup
    throw UnimplementedError();
  }
  
}