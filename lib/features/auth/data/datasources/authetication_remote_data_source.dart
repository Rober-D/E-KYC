import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_kyc/core/util.dart';
import 'package:e_kyc/features/auth/data/models/user_model.dart';
import 'package:e_kyc/features/auth/data/models/user_status_model.dart';
import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failres.dart';
import '../../domain/entities/user_status.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<Failures, Unit>> register({required UserEntity newUser});

  Future<UserStatusEntity> logIn(
      {required String emailOrUsername, required String password});

  Future<UserEntity> getUser({required String username, required String userToken});
}

// Using Register and LogIn APIs With Dio.
class AuthRemoteDataSourceDio implements AuthenticationRemoteDataSource {
  @override
  Future<UserStatusEntity> logIn(
      {required String emailOrUsername, required String password}) async {
    try {
      Map<String, dynamic> credentials = {
        "usernameOrEmail": emailOrUsername,
        "password": password
      };
      Dio dio = Dio();
      print("BEFORE");
      Response response = await dio
          .post('https://e-kyc.onrender.com/api/auth/login', data: credentials);
      print("AFTER");
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserStatusEntity userStatus = UserStatusModel.fromJson(response.data);
        return userStatus;
      } else if(response.statusCode == 401){
        /// ToDo - Make an Exception and appear response message for user.
        UserStatusEntity userStatus = response.data;
        return userStatus;
      }else{
        throw ServerException();
      }
    } on APIFailure {
      /// ToDo - Return Network Failure.
      print("Exception Is HERE");
      throw NetworkException();
    }
  }

  @override
  Future<Either<Failures, Unit>> register({required UserEntity newUser}) async {
    try {
      Dio dio = Dio();
      Map<String,dynamic>data = {
        "username": newUser.userName,
        "email": newUser.email,
        "password": newUser.password,
        "mobileNumber": newUser.mobileNumber,
        "birthdate": newUser.birthdate,
        "nationalId": newUser.nationalId,
        "gender": newUser.gender
      };
      Response response = await dio.post('https://e-kyc.onrender.com/api/auth/register',data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
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
  Future<UserEntity> getUser({required String username, required String userToken}) async{
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = "Bearer $userToken";
      Response response = await dio
          .get('https://e-kyc.onrender.com/users/$username');
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserEntity user = UserModel.fromJson(response.data);
        return user;
      } else {
        /// ToDo - Make an Exception and appear response message for user.
        throw ServerException();
      }
    } on APIFailure {
      /// ToDo - Return Network Failure.
      throw NetworkException();
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
