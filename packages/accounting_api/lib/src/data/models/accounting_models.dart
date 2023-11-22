import 'package:equatable/equatable.dart';
import 'package:organisation_api/organisation_api.dart';

class Classification extends Equatable {

  Classification({this.id, required this.number, required this.name});

  final String? id;
  final String number;
  final String name;

  @override
  List<Object?> get props => [id];

}

class Module extends Equatable {

  Module({required this.id, required this.name, required this.account});

  factory Module.fromJson(Map<String, dynamic> json) {
    final Account account = Account.fromJson(json['compte']);
    return Module(id: json['id'], name: json['intitule'], account: account);
  }

  final String id;
  final String name;
  final Account account;

  @override
  List<Object?> get props => [id];

}

class Account extends Equatable {

  Account({this.id, required this.number, required this.name, required this.organisation, required this.accountType});

  factory Account.fromJson(Map<String, dynamic> json) {
    final Organisation organisation = Organisation.fromJson(json['organisation']);
    final AccountType accountType = AccountType.fromJson(json['type_compte']);
    return Account(
        id: json['id'], number: json['numero'], name: json['intitule'], organisation: organisation,
        accountType: accountType
    );
  }

  final String? id;
  final String number;
  final String name;
  final Organisation organisation;
  final AccountType accountType;

  @override
  List<Object?> get props => [id, number, name, organisation];

}

class AccountType extends Equatable {

  AccountType({this.id, required this.name});

  factory AccountType.fromJson(Map<String, dynamic> json) {
    return AccountType(id: json['id'], name: json['intitule']);
  }

  final String? id;
  final String name;

  @override
  List<Object?> get props => [id];

}