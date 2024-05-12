import 'package:dartz/dartz.dart';
import '../../../../core/error/failres.dart';

abstract class AuthenticationRepository{
  Future<Either<Failures,Unit>> register();
  Future<Either<Failures,Unit>> logIn({required String emailOrUsername, required String password});
}