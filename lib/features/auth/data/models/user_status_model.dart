import 'package:e_kyc/features/auth/domain/entities/user_status.dart';

class UserStatusModel extends UserStatusEntity {
  const UserStatusModel({required super.userToken,
    required super.tokenType,
    required super.errorMessage});

  factory UserStatusModel.fromJson(Map<String, dynamic>json){
    return UserStatusModel(userToken: json["accessToken"],
        tokenType: json["tokenType"],
        errorMessage: json["errorMessage"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': userToken,
      'tokenType': tokenType,
      'errorMessage': errorMessage,
    };
  }
}
