import 'package:dartz/dartz.dart';
import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/failres.dart';
import '../entities/user_status.dart';

abstract class AuthenticationRepository{
  Future<Either<Failures,Unit>> register({required UserEntity newUser});
  Future<Either<UserStatusFailedEntity,UserStatusSuccessEntity>> logIn({required String emailOrUsername, required String password});
  Future<UserEntity> getUser({required String username, required String userToken});
}