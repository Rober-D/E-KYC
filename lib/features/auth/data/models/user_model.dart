import 'package:e_kyc/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.userName,
      required super.email,
      required super.password,
      required super.mobileNumber,
      required super.birthdate,
      required super.nationalId,
      required super.role,
      required super.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) {
      return UserModel(
          userName: json["username"],
          mobileNumber: json["mobileNumber"],
          gender: json["gender"],
          birthdate: json["birthdate"],
          email: json["email"],
          nationalId: json["nationalId"],
          password: json["password"],
          role: json["role"]
      );
  }

  Map<String,dynamic> toJson(){
      return {
          'username': userName,
          'mobileNumber': mobileNumber,
          'gender': gender,
          'birthdate': birthdate,
          'email': email,
          'national_id':nationalId,
          'password': password,
          'role': role,
      };
  }
}
