import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:native_context_menu/native_context_menu.dart';

import 'package:trust_app/organisation/data/repository/server_repository.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {

  ServerBloc() : super(const ServerState()) {

    // on<AppStartedEvent>((event, emit) async {
    //   final address = await server.getServers();
    //   add(ServerCheckEvent(current: address['current'], servers: address['all']));
    // });
    //
    // on<ServerCheckEvent>((event, emit) async {
    //   if (event.current == null) {
    //     await Future.delayed(const Duration(seconds: 2));
    //     return emit(state.copyWith(status: ServerStatus.empty, servers: event.servers));
    //   }
    //   try {
    //     await server.status(event.current as String);
    //     emit(state.copyWith(
    //         status: ServerStatus.success,
    //         current: event.current,
    //         servers: event.servers,
    //         isUpdating: false
    //     ));
    //   } catch (_) {
    //     emit(state.copyWith(
    //         status: ServerStatus.failure,
    //         current: event.current,
    //         servers: event.servers,
    //         isUpdating: false
    //     ));
    //   }
    //
    // });
    //
    // on<ServerAtivateEvent>((event, emit) async {
    //   final current = await server.activateServer(event.current as String);
    //   emit(
    //       state.copyWith(
    //           status: ServerStatus.initial,
    //           servers: state.servers,
    //           current: current
    //       )
    //   );
    //   add(ServerCheckEvent(current: current, servers: state.servers));
    // });
    //
    // on<ServerAddEvent>((event, emit) async {
    //   final address = await server.addServer(event.addValue);
    //   emit(state.copyWith(status: ServerStatus.initial, current: address['current'], servers: address['all']));
    //   add(ServerCheckEvent(current: address['current'], servers: address['all']));
    // });
    //
    // on<ServerUpdateEvent>((event, emit) async {
    //   final address = await server.updateServer(event.oldValue, event.newValue);
    //   if (event.oldValue == state.current) {
    //     emit(state.copyWith(status: state.status, current: address['current'],
    //         servers: address['all'], isUpdating: true));
    //     return add(ServerCheckEvent(current: address['current'], servers: address['all']));
    //   }
    //   emit(state.copyWith(status: state.status, current: address['current'], servers: address['all'], isUpdating: true));
    //   await Future.delayed(const Duration(seconds: 1), () {
    //     emit(state.copyWith(status: state.status, current: address['current'],
    //         servers: address['all'], isUpdating: false));
    //   });
    // });
    //
    // on<ServerRemoveEvent>((event, emit) async {
    //   final address = await server.removeServer(event.deleteServer);
    //
    //   emit(
    //       state.copyWith(
    //           status: ServerStatus.removed,
    //           current: address['current'],
    //           servers: address['all']
    //       )
    //   );
    //
    //   if (List.of(address['all']).length == 1) {
    //     emit(
    //         state.copyWith(
    //             status: ServerStatus.initial,
    //             current: address['all'][0],
    //             servers: address['all']
    //         )
    //     );
    //     add(ServerCheckEvent(current: address['all'][0], servers: address['all']));
    //   }
    // });

  }

}

