import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_api/organisation_api.dart';

import 'package:server_api/server_api.dart';
import 'package:utils/utils.dart';

class TypeOrganisationMenuCubit extends Cubit<List<TypeOrganisation>> {
  TypeOrganisationMenuCubit({required this.typeOrganisationRepository, required this.connectivityStatus,
  required this.apiStatus}) : super([]);

  final TypeOrganisationRepository typeOrganisationRepository;

  final ConnectivityStatusCubit connectivityStatus;
  final TypeOrganisationApiStatusCubit apiStatus;

  void getAll() async {
    if (connectivityStatus.state == ConnectivityStatus.connected) {
      try {
        final typeOrganisation = await typeOrganisationRepository.getTypeOrganisation();
          emit(typeOrganisation);
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
