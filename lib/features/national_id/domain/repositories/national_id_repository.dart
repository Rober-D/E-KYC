import 'package:dartz/dartz.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import '../../../../core/error/failres.dart';

abstract class NationalIdRepository{
  Future<Either<Failures,NationalIdEntity>> getNationalId();
  Future<Either<Failures,Unit>> updateNationalId();
  Future<Either<Failures,Unit>> deleteNationalId();
}