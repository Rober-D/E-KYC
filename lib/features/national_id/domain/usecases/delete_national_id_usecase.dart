import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';

class DeleteNationalIdUseCase{
  final NationalIdRepository nationalIdRepository;

  DeleteNationalIdUseCase({required this.nationalIdRepository});

  Future<Either<Failures,Unit>>call() async{
    return await nationalIdRepository.deleteNationalId();
  }
}