import 'package:equatable/equatable.dart';
import 'currency.dart';
import 'language.dart';

part 'activity.dart';
part 'country.dart';

class Organisation extends Equatable {
  Organisation({required this.name, required this.country, required this.typeOrganisation, this.id, this.address,
    this.activities, this.email, this.telephone, this.logo, this.register, this.idNat, this.numeroImpot,
    this.numeroSocial, this.numeroEmployeur });

  factory Organisation.fromJson(Map<String, dynamic> json) {
    final country = Country.fromJson(json['pays']);
    final typeOrganisation = TypeOrganisation.fromJson(json['type_organisation']);
    final activities = List.from(json['activites']).map((e) => Activity.fromJson(e)).toList();

    return Organisation(
      id: json['id'], name: json['nom'], address: json['adresse'], email: json['email'], telephone: json['telephone'],
      logo: json['logo'], register: json['registre'], idNat: json['id_nat'], numeroImpot: json['numero_impot'],
      numeroSocial: json['numero_social'], numeroEmployeur: json['numero_employeur'], activities: activities,
      country: country, typeOrganisation: typeOrganisation,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>  data = {
      'nom': name, 'adresse': address, 'country_id': country.id, 'activites': activities, 'email': email,
      'telephone': telephone, 'type_organisation_id': typeOrganisation.id, 'register': register, 'id_nat': idNat,
      'numero_impot': numeroImpot, 'numero_social': numeroSocial, 'numero_employeur': numeroEmployeur};

    return data;

  }

  final String? id;
  late final String name;
  late final String? address;
  late final Country country;
  late final List<Activity>? activities;
  late final String? email;
  late final String? telephone;
  late final String? logo;
  late final TypeOrganisation typeOrganisation;
  late final String? register;
  late final String? idNat;
  late final String? numeroImpot;
  late final String? numeroSocial;
  late final String? numeroEmployeur;

  @override
  List<Object?> get props => [id];
}

class TypeOrganisation extends Equatable {
  TypeOrganisation({required this.id, required this.name});

  final String id;
  final String name;
  
  factory TypeOrganisation.fromJson(Map<String, dynamic> json) {
    return TypeOrganisation(id: json['id'], name: json['intitule']);
  }

  @override
  List<Object?> get props => [name];

}
