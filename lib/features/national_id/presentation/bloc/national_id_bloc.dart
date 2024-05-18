import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_kyc/features/national_id/domain/entities/national_id_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/create_national_id_usecase.dart';
import '../../domain/usecases/delete_national_id_usecase.dart';
import '../../domain/usecases/get_national_id_usecase.dart';
import '../../domain/usecases/update_national_id_usecase.dart';

part 'national_id_event.dart';

part 'national_id_state.dart';

class NationalIdBloc extends Bloc<NationalIdEvent, NationalIdState> {
  final CreateNationalIdUseCase createNationalIdUseCase;
  final GetNationalIdUseCase getNationalIdUseCase;
  final UpdateNationalIdUseCase updateNationalIdUseCase;
  final DeleteNationalIdUseCase deleteNationalIdUseCase;

  NationalIdBloc(
      {required this.createNationalIdUseCase,
      required this.getNationalIdUseCase,
      required this.updateNationalIdUseCase,
      required this.deleteNationalIdUseCase})
      : super(NationalIdInitial()) {
    on<NationalIdEvent>((event, emit) async {
      if (event is GetNationalIdEvent) {
        emit(LoadingNationalIdState());
        await getNationalIdUseCase(
            userNationalId: event.nationalId, userToken: event.token);
        emit(LoadedNationalIdState(nationalId: event.nationalIdEntity));
      } else if (event is CreateNationalIdEvent) {
        emit(LoadingNationalIdState());
        await createNationalIdUseCase(
            newUserNationalId: event.newNationalIdCard, userToken: event.token);
        emit(LoadedNationalIdState(nationalId: event.newNationalIdCard));
      } else if (event is UpdateNationalIdEvent) {
        emit(LoadingNationalIdState());
        await updateNationalIdUseCase(
            updatedUserNationalId: event.updatedNationalIdCard,
            userToken: event.token);
        emit(LoadedNationalIdState(nationalId: event.updatedNationalIdCard));
      } else if (event is DeleteNationalIdEvent) {}
    });
  }
}
