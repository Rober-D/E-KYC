import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userName;
  final String? email;
  final String? password;
  final String? mobileNumber;
  final String? birthdate;
  final String? nationalId;
  final String? role;
  final String? gender;

  const UserEntity(
      {required this.userName,
      required this.email,
      required this.password,
      required this.mobileNumber,
      required this.birthdate,
      required this.nationalId,
      required this.role,
      required this.gender});

  @override
  List<Object?> get props => [
        userName,
        email,
        password,
        mobileNumber,
        birthdate,
        nationalId,
        role,
        gender
      ];
}
