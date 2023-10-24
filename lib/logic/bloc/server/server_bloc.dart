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

      _server.status(host: event.host, port: event.port).listen((response) {
        _serverSubscription = response.asStream().listen((status) => add(AvailibleServerEvent(status)));
      });

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

    on<ServerAddedEvent>((event, emit) {
      switch (event.isSuccessful) {
        case true:
          emit(const ServerAdding(adding: true));
          break;
        case false:
          emit(const ServerAdding(adding: false));
          break;
      }
    });

  }

  @override
  Future<void> close() {
    _serverSubscription?.cancel();
    return super.close();
  }
}
