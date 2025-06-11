import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eco_bike/features/auth/data/models/signin_req_params.dart';
import 'package:eco_bike/features/auth/data/models/signup_req_params.dart';
import 'package:eco_bike/features/core/const/api_urls.dart';
import 'package:eco_bike/features/core/network/dio_client.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> getUser();
  Future<Either> signin(SigninReqParams signinReq);
}

class AuthApiServiceImpl extends AuthApiService {
  final DioClient _dioClient;

  AuthApiServiceImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      var response = await _dioClient.post(
        ApiUrls.register,
        data: signupReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      );
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var response = await _dioClient.get(ApiUrls.userProfile);
      return Right(response);
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      );
    }
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    try {
      var response = await _dioClient.post(
        ApiUrls.login,
        data: signinReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(
        e.response?.data['message'] ?? e.message ?? 'Something went wrong',
      );
    }
  }
}
