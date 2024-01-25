import 'package:dartz/dartz.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/features/authentication/domain/entities/user_entity.dart';

abstract class AuthenticationRepository{
  ///if havent internet connection or any exception it will return [failure]
  Future<Either<Failure,UserEntity>> googleSignin();
Either<Failure, UserEntity> getCurrentUser();
}