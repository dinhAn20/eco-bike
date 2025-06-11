
import 'package:eco_bike/features/auth/domain/repository/auth_repository.dart';
import 'package:eco_bike/features/core/usecase/usecase.dart';
import 'package:eco_bike/injection_container.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {

  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
  
}