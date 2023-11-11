import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  Currency({required this.id, required this.name, required this.symbol, required this.codeIso, required this.unit});

  final String id;
  final String name;
  final String symbol;
  final String codeIso;
  final double unit;

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(id: json['id'], name: json['intitule'], symbol: json['symbole'], codeIso: json['code_iso'],
        unit: json['unite']);
  }

  @override
  List<Object?> get props => [codeIso];


}