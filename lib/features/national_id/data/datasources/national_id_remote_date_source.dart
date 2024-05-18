import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_kyc/core/error/exceptions.dart';
import 'package:e_kyc/core/error/failres.dart';
import 'package:e_kyc/features/auth/data/models/user_status_failed_model.dart';
import 'package:e_kyc/features/national_id/data/models/national_id_model.dart';
import '../../../auth/domain/entities/user_status.dart';
import '../../domain/entities/national_id_entity.dart';
import '../../domain/entities/server_entity.dart';

abstract class NationalIdRemoteDataSource {
  Future<Either<UserStatusFailedEntity, NationalIdEntity>> getNationalId(
      {required String userNationalId, required String userToken});

  Future<Unit> createNationalId(
      {required NationalIdEntity newUserNationalId, required String userToken});

  Future<Unit> updateNationalId(
      {required NationalIdEntity updatedUserNationalId,
      required String userToken});

  Future<Unit> deleteNationalId();

  Future<ServerEntity> getServerLink();
}

class NationalIdRemoteDataSourceDio implements NationalIdRemoteDataSource {
  @override
  Future<Unit> createNationalId(
      {required NationalIdEntity newUserNationalId,
      required String userToken}) async {
    try {
      Dio dio = Dio();
      Map<String, dynamic> data = {
        "firstName": newUserNationalId.firstName,
        "lastName": newUserNationalId.lastName,
        "address": newUserNationalId.address,
        "nationalId": newUserNationalId.nationalId,
        "birthdate": newUserNationalId.birthday,
        "gender": newUserNationalId.gender,
        "idStatus": "PENDING",
        "contractAmount": 250,
        "frontIdImage": newUserNationalId.image,
        "rejectionComment": ""
      };
      dio.options.headers['Authorization'] = "Bearer $userToken";
      String url = "https://kyc-75cv.onrender.com/api/nationalId/add";
      Response response = await dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw APIException();
    }
  }

  @override
  Future<Unit> deleteNationalId() {
    // TODO: implement deleteNationalId
    throw UnimplementedError();
  }

  @override
  Future<Either<UserStatusFailedEntity, NationalIdEntity>> getNationalId(
      {required String userNationalId, required String userToken}) async {
    try {
      Dio dio = Dio();
      print("NationalID is : $userNationalId");
      dio.options.headers['Authorization'] = "Bearer $userToken";
      String url =
          "https://kyc-75cv.onrender.com/api/nationalId/by-national-id/$userNationalId";
      Response response = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            // Allow all statuses to be handled in the response
            return status! < 500;
          },
        ),
      );
      print("HERE IS THE PRINT MSG");
      if (response.statusCode == 200 || response.statusCode == 201) {
        NationalIdEntity nationalId = NationalIdModel.fromJson(response.data);
        return Right(nationalId);
      } else {
        UserStatusFailedEntity userStatusFailedEntity =
            UserStatusFailedModel.fromJson(response.data);
        return Left(userStatusFailedEntity);
      }
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Unit> updateNationalId(
      {required NationalIdEntity updatedUserNationalId,
      required String userToken}) async {
    try {
      Dio dio = Dio();
      Map<String, dynamic> data = {
        "firstName": updatedUserNationalId.firstName,
        "lastName": updatedUserNationalId.lastName,
        "address": updatedUserNationalId.address,
        "nationalId": updatedUserNationalId.nationalId,
        "birthdate": updatedUserNationalId.birthday,
        "gender": updatedUserNationalId.gender,
        "idStatus": "PENDING",
        "contractAmount": 250,
        "frontIdImage": updatedUserNationalId.image,
        "rejectionComment": ""
      };
      dio.options.headers['Authorization'] = "Bearer $userToken";
      String url =
          "https://kyc-75cv.onrender.com/api/nationalId/${updatedUserNationalId.id}";
      Response response = await dio.put(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw APIException();
    }
  }

  @override
  Future<ServerEntity> getServerLink() async{
    // API
    try {
      Dio dio = Dio();
      String id = "66474748f44288f8b439fec7";
      String url = "https://kyc-75cv.onrender.com/api/nationalId/$id";
      Response response = await dio.get(
        url,
        options: Options(
          validateStatus: (status) {
            // Allow all statuses to be handled in the response
            return status! < 500;
          },
        ),
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        ServerEntity serverEntity = ServerEntity(localHostServer: "");
        serverEntity.localHostServer = response.data;
        return serverEntity;
      }else{
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
