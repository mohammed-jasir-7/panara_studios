import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/features/authentication/domain/entities/user_entity.dart';
import 'package:panara_studios/features/authentication/domain/repositories/authentication_repository.dart';

@Injectable()
class GoogleSignin {
  final AuthenticationRepository repository;

  GoogleSignin({required this.repository});
  Future<Either<Failure, UserEntity>> call() async {
    return await repository.googleSignin();
  }

  Either<Failure, UserEntity> getCurrentUser() {
    return repository.getCurrentUser();
  }
}
