import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:organisation_api/src/models/country.dart';

part 'activity.dart';

class Organisation extends Equatable {
  const Organisation({required this.name, required this.country, required this.typeOrganisation, this.id, this.address,
    this.activities, this.email, this.telephone, this.logo, this.registre, this.idNat, this.numeroImpot,
    this.numeroSocial, this.numeroEmployeur });

  factory Organisation.fromJson(Map<String, dynamic> json) {
    final country = Country.fromJson(json['pays']);
    final typeOrganisation = TypeOrganisation.fromJson(json['type_organisation']);
    final activities = List.from(json['activites']).map((e) => Activity.fromJson(e)).toList();

    return Organisation(
      id: json['id'], name: json['nom'], address: json['adresse'], email: json['email'], telephone: json['telephone'],
      logo: json['logo'], registre: json['registre'], idNat: json['id_nat'], numeroImpot: json['numero_impot'],
      numeroSocial: json['numero_social'], numeroEmployeur: json['numero_employeur'], activities: activities,
      country: country, typeOrganisation: typeOrganisation,
    );
  }


  final String? id;
  final String name;
  final String? address;
  final Country country;
  final List<Activity>? activities;
  final String? email;
  final String? telephone;
  final String? logo;
  final TypeOrganisation typeOrganisation;
  final String? registre;
  final String? idNat;
  final String? numeroImpot;
  final String? numeroSocial;
  final String? numeroEmployeur;

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
