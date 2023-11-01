import 'package:bloc/bloc.dart';

import 'package:trust_app/home/data/repository/server_repository.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

class ActiveServerCubit extends Cubit<String?> {
  ActiveServerCubit({required this.serverRepository, required this.statusCubit}) : super(null);

  final ServerRepository serverRepository;
  final ConnectivityStatusCubit statusCubit;

  void get() async {
    String? activeServer = await serverRepository.getActiveServer();

    statusCubit.changeStatus(ConnectivityStatus.loading);

    if (activeServer != null) {
      emit(activeServer);
      serverRepository.status(activeServer).listen((status) {
        statusCubit.changeStatus(status);
      });
    } else {
      emit(null);
      statusCubit.changeStatus(ConnectivityStatus.none);
    }
  }

}
