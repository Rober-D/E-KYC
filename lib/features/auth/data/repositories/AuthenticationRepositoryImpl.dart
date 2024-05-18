import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/exceptions.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/core/network/network_info.dart';
import 'package:e_kyc/features/auth/data/datasources/authetication_remote_data_source.dart';
import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';
import 'package:e_kyc/features/auth/domain/entities/user_status.dart';
import '../../domain/repositories/AuthenticationRepository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<UserStatusFailedEntity,UserStatusSuccessEntity>> logIn(
      {required String emailOrUsername, required String password}) async {
    if (await networkInfo.isConnected) {
      try{
        var userStatusEntity = await remoteDataSource.logIn(
            emailOrUsername: emailOrUsername, password: password);

        return userStatusEntity;
      }on ServerFailure{
        throw ServerException();
      }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<Either<Failures, Unit>> register({required UserEntity newUser}) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.register(newUser: newUser);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<UserEntity> getUser({required String username, required String userToken}) async{
    if (await networkInfo.isConnected) {
        UserEntity user = await remoteDataSource.getUser(username: username,userToken: userToken);
        return user;
    } else {
      throw NetworkException();
    }
  }
}
