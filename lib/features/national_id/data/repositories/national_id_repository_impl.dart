import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/core/network/network_info.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/domain/entities/server_entity.dart';
import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';
import '../../../../core/error/exceptions.dart';
import '../../../auth/domain/entities/user_status.dart';
import '../datasources/national_id_remote_date_source.dart';

class NationalIdRepositoryImpl extends NationalIdRepository {
  final NationalIdRemoteDataSource nationalIdRemoteDataSource;
  final NetworkInfo networkInfo;

  NationalIdRepositoryImpl(
      {required this.nationalIdRemoteDataSource, required this.networkInfo});

  @override
  Future<Unit> createNationalId(
      {required NationalIdEntity newUserNationalId,
      required String userToken}) async {
    if (await networkInfo.isConnected) {
      try {
        await nationalIdRemoteDataSource.createNationalId(
            newUserNationalId: newUserNationalId, userToken: userToken);
        return Future.value(unit);
      } catch (e) {
        throw Exception();
      }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<Unit> deleteNationalId() async {
    if (await networkInfo.isConnected) {
      try {
        await nationalIdRemoteDataSource.deleteNationalId();
        return Future.value(unit);
      } catch (e) {
        throw Exception();
      }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<Either<UserStatusFailedEntity,NationalIdEntity>> getNationalId(
      {required String userNationalId, required String userToken}) async {
    if (await networkInfo.isConnected) {
       try{
         var nationalId =
         await nationalIdRemoteDataSource.getNationalId(
             userNationalId: userNationalId, userToken: userToken);
         return nationalId;

       }on ServerFailure{
         throw ServerException();
       }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<Unit> updateNationalId(
      {required NationalIdEntity updatedUserNationalId,
      required String userToken}) async {
    if (await networkInfo.isConnected) {
      try {
        await nationalIdRemoteDataSource.updateNationalId(
            userToken: userToken, updatedUserNationalId: updatedUserNationalId);
        return Future.value(unit);
      } catch (e) {
        throw Exception();
      }
    } else {
      throw NetworkException();
    }
  }

  @override
  Future<ServerEntity> getServerLink() async{
    if (await networkInfo.isConnected) {
      try {
        ServerEntity serverEntity = await nationalIdRemoteDataSource.getServerLink();
       return serverEntity;
      } catch (e) {
        throw Exception();
      }
    } else {
      throw NetworkException();
    }
  }
}
