import 'package:equatable/equatable.dart';

class UserStatusSuccessEntity extends Equatable {
  final String userToken;
  final String tokenType;

  const UserStatusSuccessEntity(
      {required this.userToken,
      required this.tokenType,});

  @override
  List<Object?> get props => [userToken,tokenType];
}

class UserStatusFailedEntity extends Equatable{

  final int status;
  final String errorType;
  final String errorMessage;

  const UserStatusFailedEntity({required this.status, required this.errorType, required this.errorMessage});

  @override
  List<Object?> get props => [status,errorType,errorMessage];
}