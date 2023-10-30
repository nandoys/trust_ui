import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:organisation_api/organisation_api.dart';

class OrganisationRepository {
  OrganisationRepository({required this.host, required this.protocol}) {}

  final _organisationStreamController = BehaviorSubject<List<Organisation>>.seeded(const []);
  final String host;
  final String protocol;

  /// Provides a [Stream] of all organisations.
  Stream<List<Organisation>> getOrganisations() => _organisationStreamController.asBroadcastStream();
  
  Future<void> getAll() async {
    final Uri url;
    if (protocol == 'http') {
      url = Uri.http(host, '/api/organisation');
    }
    else {
      url = Uri.https(host, '/api/organisation');
    }

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
      List<Organisation> organisations = List.from(json).map((e) => Organisation.fromJson(e)).toList();
      _organisationStreamController.add(organisations);
    } else {
      _organisationStreamController.add([]);
    }
  }

  void close() {
    _organisationStreamController.close();
  }
}

