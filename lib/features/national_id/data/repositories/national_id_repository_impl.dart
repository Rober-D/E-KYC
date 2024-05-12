import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/core/network/network_info.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:e_kyc/features/national_id/domain/repositories/national_id_repository.dart';
import '../datasources/national_id_local_data_source.dart';
import '../datasources/national_id_remote_date_source.dart';

class NationalIdRepositoryImpl extends NationalIdRepository {
  final NationalIdRemoteDataSource nationalIdRemoteDataSource;
  final NationalIdLocalDataSource nationalIdLocalDataSource;
  final NetworkInfo networkInfo;

  NationalIdRepositoryImpl(
      {required this.nationalIdRemoteDataSource,
      required this.nationalIdLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> deleteNationalId() {
    // TODO: implement deleteNationalId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, NationalIdEntity>> getNationalId() {
    // TODO: implement getNationalId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, Unit>> updateNationalId() {
    // TODO: implement updateNationalId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, Unit>> createNationalId() {
    // TODO: implement createNationalId
    throw UnimplementedError();
  }
}
