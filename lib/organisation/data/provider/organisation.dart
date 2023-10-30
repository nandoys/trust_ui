import 'package:rxdart/rxdart.dart';
import 'package:trust_app/organisation/data/model/organisation.dart';

class OrganisationProvider {
  final _organisationStreamController = BehaviorSubject<List<Organisation>>.seeded(const []);

  /// Provides a [Stream] of all organisations.
  Stream<List<Organisation>> getOrganisations() => _organisationStreamController.asBroadcastStream();
}