import 'package:equatable/equatable.dart';
import 'package:organization_api/organization_api.dart';

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
    final Account account = Account.fromJson(json['account']);

    return Module(id: json['module']['id'], name: json['module']['name'], account: account);
  }

  final String id;
  final String name;
  final Account account;

  @override
  List<Object?> get props => [id];

  /// check whether a module exist
  bool hasModule(String moduleName) {
    return name.contains(moduleName);
  }

}

class Account extends Equatable {

  Account({this.id, required this.number, required this.name, required this.organization, required this.accountType});

  factory Account.fromJson(Map<String, dynamic> json) {
    final Organization? organization = json['organization'] != null ?
    Organization.fromJson(json['organization']) : json['organization'];

    final AccountType? accountType = json['account_type'] != null ?
    AccountType.fromJson(json['account_type']) : json['account_type'];

    return Account(
        id: json['id'], number: json['number'], name: json['name'], organization: organization,
        accountType: accountType
    );
  }

  final String? id;
  final String number;
  final String name;
  final Organization? organization;
  final AccountType? accountType;

  @override
  List<Object?> get props => [id, number, name, organization];

}

class AccountType extends Equatable {

  AccountType({this.id, required this.name});

  factory AccountType.fromJson(Map<String, dynamic> json) {
    return AccountType(id: json['id'], name: json['name']);
  }

  final String? id;
  final String name;

  @override
  List<Object?> get props => [id];

}