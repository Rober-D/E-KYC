import 'package:equatable/equatable.dart';

class NationalIdImage extends Equatable{

  final String image;

  const NationalIdImage({required this.image});

  @override
  List<Object?> get props => [image];
}