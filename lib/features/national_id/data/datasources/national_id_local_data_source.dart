import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/features/national_id/data/models/national_id_model.dart';

abstract class NationalIdLocalDataSource{
  Future<Either<Failures,Unit>> sendNationalIdImage();
  Future<Either<Failures,NationalIdModel>> fetchUserNationalId();
}

class NationalIdLocalDataSourceMongoDB implements NationalIdLocalDataSource{
  @override
  Future<Either<Failures, NationalIdModel>> fetchUserNationalId() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, Unit>> sendNationalIdImage() {
    throw UnimplementedError();
  }

}