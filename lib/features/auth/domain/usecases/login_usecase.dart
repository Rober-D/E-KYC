import 'package:e_kyc/features/auth/domain/entities/user_status.dart';
import 'package:e_kyc/features/auth/domain/repositories/AuthenticationRepository.dart';

class LoginUseCase{
  final AuthenticationRepository authenticationRepository;

  LoginUseCase({required this.authenticationRepository});

  Future<UserStatusEntity> call ({required String emailOrUsername, required String password})async{
    return await authenticationRepository.logIn(emailOrUsername: emailOrUsername, password: password);
  }
}