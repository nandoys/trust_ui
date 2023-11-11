import 'package:bloc/bloc.dart';

import 'package:server_api/src/data/data.dart';

part 'connectivity_status_state.dart';

class ConnectivityStatusCubit extends Cubit<ConnectivityStatus> {
  ConnectivityStatusCubit({required this.serverRepository}) :
        super(ConnectivityStatus.loading);

  final ServerRepository serverRepository;

  void changeStatus(ConnectivityStatus status) {
    emit(status);
  }
}
