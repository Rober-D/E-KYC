import 'package:equatable/equatable.dart';

class NationalIdEntity extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String address;
  final String nationalId;
  final String status;
  final String birthday;
  final String gender;
  final String image;
  //final String manuFactorId;
  final double contractAmount;

  const NationalIdEntity(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.nationalId,
      required this.status,
      required this.birthday,
      required this.gender,
      required this.image,
      //required this.manuFactorId,
      required this.contractAmount});

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        address,
        nationalId,
        status,
        birthday,
        gender,
        image,
        //manuFactorId,
        contractAmount
      ];
}
