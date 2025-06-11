import 'package:dartz/dartz.dart';
import 'package:eco_bike/features/auth/domain/repository/auth_repository.dart';
import 'package:eco_bike/features/core/usecase/usecase.dart';
import 'package:eco_bike/injection_container.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({dynamic param}) async {
    return sl<AuthRepository>().getUser();
  }
  
}