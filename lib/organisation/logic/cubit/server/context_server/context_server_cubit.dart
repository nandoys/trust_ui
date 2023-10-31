import 'package:bloc/bloc.dart';

import 'package:trust_app/organisation/data/repository/server_repository.dart';

import 'package:trust_app/organisation/logic/cubit/server/connectivity/connectivity_status_cubit.dart';

class ContextServerCubit extends Cubit<String?> {
  ContextServerCubit({required this.serverRepository, required this.statusCubit}) : super(null);

  final ServerRepository serverRepository;
  final ConnectivityStatusCubit statusCubit;

  void getContextServer() async {
    String? contextServer = await serverRepository.getContextServer();

    if (contextServer != null) {
      emit(contextServer);
      serverRepository.status(contextServer).listen((status) {
        statusCubit.changeStatus(status);
      });
    } else {
      emit(null);
    }
  }

}
