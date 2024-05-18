import '../../domain/entities/user_status.dart';

class UserStatusFailedModel extends UserStatusFailedEntity {
  const UserStatusFailedModel({required super.status, required super.errorType, required super.errorMessage});

  factory UserStatusFailedModel.fromJson(Map<String, dynamic> json) {
    return UserStatusFailedModel(
        status: json["status"],
        errorType: json["error"],
        errorMessage: json["message"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'error': errorType,
      'message': errorMessage,
    };
  }
}