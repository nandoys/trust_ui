part of 'organisation_bloc.dart';

class OrganisationEvent extends Equatable {
  const OrganisationEvent({required this.repository});

  final OrganisationRepository repository;

  @override
  List<Object?> get props => throw UnimplementedError();
}
