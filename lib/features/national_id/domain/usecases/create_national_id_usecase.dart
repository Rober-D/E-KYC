import 'package:dartz/dartz.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';

class CreateNationalIdUseCase{
  final NationalIdRepository nationalIdRepository;

  CreateNationalIdUseCase({required this.nationalIdRepository});

  Future<Unit> call({required NationalIdEntity newUserNationalId, required String userToken}) async{
    return await nationalIdRepository.createNationalId(newUserNationalId: newUserNationalId,userToken: userToken);
  }
}