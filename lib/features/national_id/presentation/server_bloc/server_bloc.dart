import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_kyc/features/national_id/domain/entities/server_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/get_server_link_usecase.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  final GetServerLinkUseCase getServerLinkUseCase;

  ServerBloc({required this.getServerLinkUseCase}) : super(ServerInitial()) {
    on<ServerEvent>((event, emit) async{
      if(event is GetServerLinkEvent){
        emit(LoadingState());
        final server = await getServerLinkUseCase();
        emit(LoadedState());
      }
    });
  }
}
