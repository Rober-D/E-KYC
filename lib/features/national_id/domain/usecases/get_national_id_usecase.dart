import 'package:dartz/dartz.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';
import '../../../auth/domain/entities/user_status.dart';

class GetNationalIdUseCase{
  final NationalIdRepository nationalIdRepository;

  GetNationalIdUseCase({required this.nationalIdRepository});

  Future<Either<UserStatusFailedEntity,NationalIdEntity>> call({required String userNationalId, required String userToken}) async{
    return await nationalIdRepository.getNationalId(userNationalId: userNationalId, userToken: userToken);
  }
}