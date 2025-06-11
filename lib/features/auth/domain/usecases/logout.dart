import 'package:dartz/dartz.dart';
import 'package:eco_bike/features/auth/domain/repository/auth_repository.dart';
import 'package:eco_bike/features/core/usecase/usecase.dart';
import 'package:eco_bike/injection_container.dart';

class LogoutUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({param}) async {
    return await sl<AuthRepository>().logout();
  }

}