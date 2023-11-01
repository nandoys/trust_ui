import 'package:bloc/bloc.dart';
import 'package:native_context_menu/native_context_menu.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:trust_app/home/logic/cubit/organisation/organisation.dart';

class OrganisationContextMenuCubit extends Cubit<List<MenuItem>> {
  OrganisationContextMenuCubit({required this.organisationRepository, required this.activeOrganisation,
    required this.initial}) : super(initial);

  final OrganisationRepository organisationRepository;
  final ActiveOrganisationCubit activeOrganisation;
  final List<MenuItem> initial;

  void getAll() async {

  }

  void add(Organisation organisation) {

  }
}
