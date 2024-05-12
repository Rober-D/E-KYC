import 'package:dartz/dartz.dart';
import 'package:e_kyc/core/error/failres.dart';

abstract class NationalIdRemoteDataSource{
  Future<Either<Failures,Unit>> extractImage();
}

class NationalIdRemoteDataSourceHttp implements NationalIdRemoteDataSource{
  @override
  Future<Either<Failures, Unit>> extractImage() {
    throw UnimplementedError();
  }
}