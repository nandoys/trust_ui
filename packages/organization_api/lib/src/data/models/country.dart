part of 'organization.dart';

class Country extends Equatable {
  Country({required this.id, required this.name, required this.phoneCode, required this.localCurrency,
    required this.languages});

  factory Country.fromJson(Map<String, dynamic> json) {

    final currency =  Currency.fromJson(json['local_currency']);
    final language = List.from(json['languages']).map((e) => Language.fromJson(e)).toList();
    

    return Country(id: json['id'], name: json['name'], phoneCode: json['phone_code'], localCurrency: currency,
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