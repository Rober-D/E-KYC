import 'package:e_kyc/features/auth/domain/entities/user_status.dart';

class UserStatusSuccessModel extends UserStatusSuccessEntity {
  const UserStatusSuccessModel({required super.userToken,
    required super.tokenType});

  factory UserStatusSuccessModel.fromJson(Map<String, dynamic>json){
    return UserStatusSuccessModel(userToken: json["accessToken"],
        tokenType: json["tokenType"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': userToken,
      'tokenType': tokenType,
    };
  }
}
