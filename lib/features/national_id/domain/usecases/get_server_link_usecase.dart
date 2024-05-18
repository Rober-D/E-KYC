import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';
import '../entities/server_entity.dart';

class GetServerLinkUseCase{
  final NationalIdRepository nationalIdRepository;

  GetServerLinkUseCase({required this.nationalIdRepository});

  Future<ServerEntity> call() async{
    return await nationalIdRepository.getServerLink();
  }
}