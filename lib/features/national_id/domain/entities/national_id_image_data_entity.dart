import 'package:equatable/equatable.dart';

class NationalIdImageDataEntity extends Equatable{
  final List<dynamic> ocrData;
  final String status;

  const NationalIdImageDataEntity({required this.ocrData, required this.status});

  @override
  List<Object?> get props => [ocrData,status];

}