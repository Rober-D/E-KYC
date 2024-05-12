import 'package:equatable/equatable.dart';

class UserStatusEntity extends Equatable {
  final String userToken;
  final String tokenType;
  final String errorMessage;

  const UserStatusEntity(
      {required this.userToken,
      required this.tokenType,
      required this.errorMessage});

  @override
  List<Object?> get props => [userToken,tokenType,errorMessage];
}
