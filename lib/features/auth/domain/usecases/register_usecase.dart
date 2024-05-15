import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';
import 'package:e_kyc/features/auth/domain/repositories/AuthenticationRepository.dart';

class RegisterUseCase{
  final AuthenticationRepository authenticationRepository;

  RegisterUseCase({required this.authenticationRepository});

  Future<Either<Failures,Unit>> call({required UserEntity newUser}) async{
    return await authenticationRepository.register(newUser: newUser);
  }
}