import 'package:accounting_api/accounting_api.dart';
import 'package:equatable/equatable.dart';
import 'package:organisation_api/organisation_api.dart';
import 'package:utils/utils.dart';

class Tax extends Equatable {

  Tax({this.id, required this.name, required this.calculationType, required this.account, required this.country});

  final String? id;
  final String name;
  final CalculationType calculationType;
  final Account account;
  final Country country;

  @override
  List<Object?> get props => [id];

}