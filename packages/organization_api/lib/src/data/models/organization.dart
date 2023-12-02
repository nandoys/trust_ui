import 'package:equatable/equatable.dart';
import 'currency.dart';
import 'language.dart';

part 'sector.dart';
part 'country.dart';

class Organization extends Equatable {
  Organization({required this.name, required this.country, required this.organizationType, this.id, this.address,
    this.sectors, this.email, this.telephone, this.logo, this.register, this.idNat, this.taxRegistration,
    this.socialNUmber, this.employerNumber });

  factory Organization.fromJson(Map<String, dynamic> json) {
    final country = Country.fromJson(json['country']);
    final organizationType = OrganizationType.fromJson(json['organization_type']);
    final sectors = json['sectors'] == null ? null :
    List.from(json['sectors']).map((sector) => Sector.fromJson(sector)).toList();


    return Organization(
      id: json['id'], name: json['name'], address: json['address'], email: json['email'], telephone: json['telephone'],
      logo: json['logo'], register: json['register'], idNat: json['id_nat'], taxRegistration: json['tax_registration'],
      socialNUmber: json['social_number'], employerNumber: json['employer_number'], sectors: sectors,
      country: country, organizationType: organizationType,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>  data = {
      'name': name, 'address': address, 'country_id': country.id, 'sectors': sectors, 'email': email,
      'telephone': telephone, 'organization_type_id': organizationType.id, 'register': register, 'id_nat': idNat,
      'tax_registration': taxRegistration, 'social_number': socialNUmber, 'employer_number': employerNumber};

    return data;

  }

  final String? id;
  late final String name;
  late final String? address;
  late final Country country;
  late final List<Sector>? sectors;
  late final String? email;
  late final String? telephone;
  late final String? logo;
  late final OrganizationType organizationType;
  late final String? register;
  late final String? idNat;
  late final String? taxRegistration;
  late final String? socialNUmber;
  late final String? employerNumber;

  @override
  List<Object?> get props => [id];
}

class OrganizationType extends Equatable {
  OrganizationType({required this.id, required this.name});

  final String id;
  final String name;
  
  factory OrganizationType.fromJson(Map<String, dynamic> json) {
    return OrganizationType(id: json['id'], name: json['name']);
  }

  @override
  List<Object?> get props => [name];

}
