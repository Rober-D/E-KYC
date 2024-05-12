import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failres.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<Failures, Unit>> register();

  Future<Either<Failures, Unit>> logIn(
      {required String emailOrUsername, required String password});
}

// Using Register and LogIn APIs With Dio.
class AuthRemoteDataSourceDio implements AuthenticationRemoteDataSource {
  @override
  Future<Either<Failures, Unit>> logIn(
      {required String emailOrUsername, required String password}) async {
    try {
      print("Inside the Try");
      Map<String, dynamic> credentials = {
        "usernameOrEmail": emailOrUsername,
        "password": password
      };
      Dio dio = Dio();
      Response response = await dio
          .post('https://e-kyc.onrender.com/api/auth/login', data: credentials);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return const Right(unit);
      } else {
        /// ToDo - Make an Exception and appear response message for user.
        throw ServerException();
      }
    } on APIFailure {
      /// ToDo - Return Network Failure.
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> register() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get('API_link_for_registration');
      if (response.statusCode == 201) {
        return const Right(unit);
      } else {
        /// ToDo - Make an Exception and appear response message for user.
        throw ServerException();
      }
    } catch (e) {
      /// ToDo - Make a API Exception.
      throw APIException();
    }
  }
}
/*
void fetchData() async {
  Dio dio = Dio();
  try {
    Response response = await dio.get('https://api.example.com/data');
    if (response.statusCode == 200) {
      print("Request successful");
      print(response.data); // Do something with the response data
    } else {
      print("Request failed with status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error occurred: $e"); // Handle error
  }
}
 */
