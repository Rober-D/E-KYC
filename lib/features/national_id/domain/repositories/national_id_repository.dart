import 'package:dartz/dartz.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import '../../../../core/error/failres.dart';

abstract class NationalIdRepository {
  Future<NationalIdEntity> getNationalId({required String userNationalId, required String userToken});

  Future<Unit> createNationalId({required NationalIdEntity newUserNationalId, required String userToken});

  Future<Unit> updateNationalId(
      {required NationalIdEntity updatedUserNationalId, required String userToken});

  Future<Unit> deleteNationalId();
}
