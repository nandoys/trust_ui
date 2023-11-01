import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organisation_api/organisation_api.dart';

part 'organisation_event.dart';
part 'organisation_state.dart';

class OrganisationBloc extends Bloc<OrganisationEvent, OrganisationState> {
  OrganisationBloc() : super(OrganisationInitial()) {
    on<OrganisationEvent>((event, emit) async {
      // serverBloc.stream.listen((event) {
      //   print("boss this is your state ${event.status}");
      // });
      // event.repository.getAll();
      //
      // event.repository.getOrganisations().forEach((element) {
      //   print(element);
      // });

    });
  }

  late StreamSubscription _organisationSubscription;

  @override
  Future<void> close() {
    _organisationSubscription.cancel();
    return super.close();
  }
}
