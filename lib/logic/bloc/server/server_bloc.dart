import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trust_app/logic/bloc/server/server.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  final Server _server;

  StreamSubscription<bool>? _serverSubscription;

  ServerBloc({required Server server}) : _server = server, super(const ServerInitializing()) {

    on<StartServerCheckEvent>((event, emit) {
      _serverSubscription?.cancel();

      _serverSubscription = _server.status().listen((status) => add(AvailibleServerEvent(status)));
    });

    on<AvailibleServerEvent>((event, emit) {
      switch (event._status) {
        case true:
          emit(const ServerIsRunning());
          break;
        case false:
          emit(const ServerIsNotRunning());
          break;
        default:
          emit(const ServerIsNotRunning());
      }
    });

  }

  @override
  Future<void> close() {
    _serverSubscription?.cancel();
    return super.close();
  }
}
