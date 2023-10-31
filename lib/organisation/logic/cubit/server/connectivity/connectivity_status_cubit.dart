import 'package:bloc/bloc.dart';

import 'package:trust_app/organisation/logic/cubit/server/context_server/context_server_cubit.dart';

import 'package:trust_app/organisation/data/repository/server_repository.dart';

part 'connectivity_status_state.dart';

class ConnectivityStatusCubit extends Cubit<ConnectivityStatus> {
  ConnectivityStatusCubit({required this.serverRepository}) :
        super(ConnectivityStatus.loading);

  final ServerRepository serverRepository;

  void changeStatus(ConnectivityStatus status) {
    emit(status);
    print('from ConnectivityStatusCubit cubit $status');
  }
}
