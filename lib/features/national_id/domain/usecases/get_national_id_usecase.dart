import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';

class GetNationalIdUseCase{
  final NationalIdRepository nationalIdRepository;

  GetNationalIdUseCase({required this.nationalIdRepository});

  Future<Either<Failures,NationalIdEntity>> call() async{
    return await nationalIdRepository.getNationalId();
  }
}