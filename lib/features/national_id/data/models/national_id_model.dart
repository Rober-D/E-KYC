import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';

class NationalIdModel extends NationalIdEntity {
  const NationalIdModel({required super.firstName,
    required super.lastName,
    required super.address,
    required super.nationalId,
    required super.status,
    required super.birthday,
    required super.gender,
    required super.image,
    required super.contractAmount});

  factory NationalIdModel.fromJson(Map<String, dynamic>json){
    return NationalIdModel(firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
        nationalId: json["nationalId"],
        status: json["status"],
        birthday: json["birthday"],
        gender: json["gender"],
        image: json["frontIdImage"],
        contractAmount: json["contractAmount"]);
  }

  Map<String,dynamic> toJson(){
    return{
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'nationalId': nationalId,
      'status': status,
      'birthday': birthday,
      'frontIdImage': image,
      'contractAmount': contractAmount,
    };
  }
}
