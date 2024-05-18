import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';
import 'package:e_kyc/features/auth/domain/repositories/AuthenticationRepository.dart';

class GetUserUseCase{
  final AuthenticationRepository authenticationRepository;

  GetUserUseCase({required this.authenticationRepository});

  Future<UserEntity> call ({required String username, required String userToken})async{
    return await authenticationRepository.getUser(username: username, userToken: userToken);
  }
}