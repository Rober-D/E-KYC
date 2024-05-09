import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/features/auth/domain/repositories/AuthenticationRepository.dart';

class LoginUseCase{
  final AuthenticationRepository authenticationRepository;

  LoginUseCase({required this.authenticationRepository});

  Future<Either<Failures,Unit>> call ()async{
    return await authenticationRepository.logIn();
  }
}