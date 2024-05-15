import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';

class UpdateNationalIdUseCase{
  final NationalIdRepository nationalIdRepository;

  UpdateNationalIdUseCase({required this.nationalIdRepository});

  Future<Unit>call({required NationalIdEntity updatedUserNationalId, required String userToken}) async{
    return await nationalIdRepository.updateNationalId(updatedUserNationalId: updatedUserNationalId, userToken: userToken);
  }
}