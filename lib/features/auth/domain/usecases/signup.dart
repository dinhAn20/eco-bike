import 'package:dartz/dartz.dart';
import 'package:eco_bike/features/auth/data/models/signup_req_params.dart';
import 'package:eco_bike/features/auth/domain/repository/auth_repository.dart';
import 'package:eco_bike/features/core/usecase/usecase.dart';
import 'package:eco_bike/injection_container.dart';

class SignupUseCase implements UseCase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthRepository>().signup(param!);
  }
}
