import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:trust_app/logic/bloc/server/server.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  final Server server;

  StreamSubscription<bool>? _serverSubscription;

  ServerBloc({required this.server}) : super(const ServerState()) {

    on<StartServerCheckEvent>((event, emit) async {
      if (event.current == null) {
        await Future.delayed(const Duration(seconds: 2));
        return emit(state.copyWith(status: ServerStatus.empty));
      }
      try {
        await server.status(event.current as String);
        emit(state.copyWith(status: ServerStatus.success, current: event.current, servers: event.servers));
      } catch (_) {
        emit(state.copyWith(status: ServerStatus.failure, current: event.current, servers: event.servers));
      }

    });

    // on<ServerAtivatedEvent>((event, emit) {
    //   _serverSubscription?.cancel();
    //   emit(ServerActivate(address: event.address));
    //   server.status(event.address).listen((response) {
    //     _serverSubscription = response.asStream().listen((status) =>
    //         add(AvailibleServerEvent(status, event.address, event.servers)));
    //   });
    // });
    //
    on<ServerAddedEvent>((event, emit) {
      add(StartServerCheckEvent(current: event.current, servers: event.servers));
    });

    //
    // on<ServerRemovedEvent>((event, emit) {
    //   server.removeServer(event.address).then((addresses) {
    //     emit(ServerRemove(addresses: addresses));
    //   });
    //
    // });

  }

  @override
  Future<void> close() {
    _serverSubscription?.cancel();
    return super.close();
  }
}
