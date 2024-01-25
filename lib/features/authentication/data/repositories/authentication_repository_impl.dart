import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';
import 'package:panara_studios/core/connection/network_info.dart';
import 'package:panara_studios/core/errors/exceptions.dart';
import 'package:panara_studios/core/errors/failure.dart';
import 'package:panara_studios/features/authentication/data/datasources/google_signing_source.dart';
import 'package:panara_studios/features/authentication/domain/entities/user_entity.dart';
import 'package:panara_studios/features/authentication/domain/repositories/authentication_repository.dart';
@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final NetworkInfo networkInfo;
  final GoogleSignDataSource remoteDataSource;

  AuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, UserEntity>> googleSignin() async {
    if (await networkInfo.isConnected!) {
      try {
        var result =await remoteDataSource.signInWithGoogle();
        if (result.isNewUser) {
        await  remoteDataSource.saveToDatabase(user: result);
        }
        return right(result );
      } on ServerException {
        return left(ServerFailure(errorMessage: 'Something went wrong'));
      }
    } else {
      return left(InternetFailure(errorMessage: 'No internet access'));
    }
  }
  
  @override
   Either<Failure, UserEntity>  getCurrentUser(){
  var data= remoteDataSource.getCurrentUserFromDb();
  if (data==null) {
   return left(ServerFailure(errorMessage: 'No user'));
    
  }else{
   return right(data);
  }
  }
}
