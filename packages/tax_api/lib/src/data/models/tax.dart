import 'package:accounting_api/accounting_api.dart';
import 'package:equatable/equatable.dart';
import 'package:organization_api/organization_api.dart';
import 'package:utils/utils.dart';

class Tax extends Equatable {

  Tax({this.id, required this.name, required this.calculationMode, required this.account, required this.country});

  factory Tax.fromJson(Map<String, dynamic> json) {
    late final CalculationMode mode;
    final account = Account.fromJson(json['account']);
    final country = Country.fromJson(json['country']);

    if (json['calculation_mode'] == 'percent') {
      mode = CalculationMode.percent;
    } else {
      mode = CalculationMode.fix;
    }

    return Tax(name: json['name'], calculationMode: mode, account: account, country: country);
  }

  final String? id;
  final String name;
  final CalculationMode calculationMode;
  final Account account;
  final Country country;

  @override
  List<Object?> get props => [id];

}