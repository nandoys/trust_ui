import 'package:equatable/equatable.dart';

import 'package:organisation_api/src/models/currency.dart';

import 'package:organisation_api/src/models/language.dart';

class Country extends Equatable {
  Country({required this.id, required this.name, required this.phoneCode, required this.localCurrency,
    required this.languages});

  factory Country.fromJson(Map<String, dynamic> json) {

    final currency =  Currency.fromJson(json['monnaie_locale']);
    final language = List.from(json['langues']).map((e) => Language.fromJson(e)).toList();
    

    return Country(id: json['id'], name: json['nom'], phoneCode: json['indicatif'], localCurrency: currency,
        languages: language);
  }

  final String id;
  final String name;
  final String phoneCode;
  final Currency localCurrency;
  final List<Language> languages;

  @override
  List<Object?> get props => [name];
}