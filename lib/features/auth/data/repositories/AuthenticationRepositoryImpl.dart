import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/exceptions.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/core/network/network_info.dart';
import 'package:e_kyc/features/auth/data/datasources/authetication_remote_data_source.dart';
import '../../domain/repositories/AuthenticationRepository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository{

  final AuthenticationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> logIn({required String emailOrUsername, required String password}) async{
    if(await networkInfo.isConnected){
      try{
        await remoteDataSource.logIn(emailOrUsername: emailOrUsername,password: password);
        return const Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      throw NetworkException();
    }
  }

  @override
  Future<Either<Failures, Unit>> register() async{
    if(await networkInfo.isConnected){
      try{
        await remoteDataSource.register();
        return const Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      throw NetworkException();
    }
  }
}