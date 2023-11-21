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

class Account extends Equatable {

  Account({this.id, required this.number, required this.name, required this.organisation, required this.accountType});

  final String? id;
  final String number;
  final String name;
  final Organisation organisation;
  final AccountType accountType;

  @override
  List<Object?> get props => [id];

}

class AccountType extends Equatable {

  AccountType({this.id, required this.name});

  final String? id;
  final String name;

  @override
  List<Object?> get props => [id];

}