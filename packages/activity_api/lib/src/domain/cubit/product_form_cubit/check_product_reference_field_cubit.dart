import 'package:activity_api/activity_api.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:server_api/server_api.dart';
import 'package:organization_api/organization_api.dart';
import 'package:utils/utils.dart';

class CheckProductReferenceFieldCubit extends Cubit<bool> {
  CheckProductReferenceFieldCubit({required this.repository, required this.connectivityStatus, required this.apiStatus})
      : super(false);

  final ProductRepository repository;
  final ConnectivityStatusCubit connectivityStatus;
  final ProductApiStatusCubit apiStatus;

  void checkField(Organization organization, String value, String token) async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {

      try {
        final bool isReferenceFieldExist = await repository.checkField(organization, 'reference', value, token);
        emit(isReferenceFieldExist);
      }
      on http.ClientException {
        connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
      }
      catch (e) {
        apiStatus.changeStatus(ApiStatus.failed);
      }
    }

  }
}
