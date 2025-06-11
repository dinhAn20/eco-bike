import 'package:dartz/dartz.dart';
import 'package:eco_bike/features/auth/data/models/signin_req_params.dart';
import 'package:eco_bike/features/auth/domain/repository/auth_repository.dart';
import 'package:eco_bike/features/core/usecase/usecase.dart';
import 'package:eco_bike/injection_container.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams> {

  @override
  Future<Either> call({SigninReqParams ? param}) async {
    return sl<AuthRepository>().signin(param!);
  }
  
}