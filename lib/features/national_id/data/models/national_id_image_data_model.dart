import 'package:e_kyc/features/national_id/domain/entities/national_id_image_data_entity.dart';

class NationalIdImageDataModel extends NationalIdImageDataEntity{
  NationalIdImageDataModel({required super.ocrData, required super.status});

  factory NationalIdImageDataModel.fromJson(Map<String, dynamic> json) {
    return NationalIdImageDataModel(
        ocrData: json["ocr_data"],
        status: json["status"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'ocr_data': ocrData,
      'status': status,
    };
  }
}