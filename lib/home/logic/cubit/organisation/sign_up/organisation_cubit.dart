import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/cubit.dart';

import 'package:trust_app/utils.dart';

class OrganisationCubit extends Cubit<bool> {
  OrganisationCubit({required this.organisationRepository, required this.connectivityStatus, required this.apiStatus})
      : super(false);
  final OrganisationRepository organisationRepository;
  final ConnectivityStatusCubit connectivityStatus;
  final OrganisationApiStatusCubit apiStatus;

  void create(Organisation organisation) async {
    try {
      Organisation? response = await organisationRepository.add(organisation);

      if (connectivityStatus.state == ConnectivityStatus.disconnected){
        connectivityStatus.changeStatus(ConnectivityStatus.connected);
      }
    }
    on http.ClientException {
      connectivityStatus.changeStatus(ConnectivityStatus.disconnected);
    }
    catch (e) {
      apiStatus.changeStatus(ApiStatus.failed);
    }
  }

}
