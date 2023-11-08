import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:trust_app/home/data/repository/server_repository.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';
import 'package:trust_app/utils.dart';

part 'active_server_state.dart';

class ActiveServerCubit extends Cubit<ActiveServerState> {
  ActiveServerCubit({required this.serverRepository, required this.statusCubit}) : super(ActiveServerInitial());

  final ServerRepository serverRepository;
  final ConnectivityStatusCubit statusCubit;

  void get() async {
    String? activeServer = await serverRepository.getActiveServer();

    statusCubit.changeStatus(ConnectivityStatus.loading);

    if (activeServer != null) {
      final url = formatServers(activeServer).split(':');
      final protocol = url[0];
      final host = url[1];
      final port = int.parse(url[2]);

      emit(ActiveServerSelected(protocol: protocol, host: host, port: port, fullAddress: activeServer));
      serverRepository.status(activeServer).listen((status) {
        statusCubit.changeStatus(status);
      });
    } else {
      emit(ActiveServerInitial());
      statusCubit.changeStatus(ConnectivityStatus.none);
    }
  }

}
