import 'package:bloc/bloc.dart';
import 'package:organisation_api/organisation_api.dart';

class ActiveOrganisationCubit extends Cubit<String?> {
  ActiveOrganisationCubit({required this.organisationRepository}) : super(null);

  final OrganisationRepository organisationRepository;
}
