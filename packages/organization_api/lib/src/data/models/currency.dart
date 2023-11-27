import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  Currency({required this.id, required this.name, required this.symbol, required this.isoCode, required this.unit});

  final String id;
  final String name;
  final String symbol;
  final String isoCode;
  final double unit;

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(id: json['id'], name: json['name'], symbol: json['symbol'], isoCode: json['iso_code'],
        unit: json['unit']);
  }

  @override
  List<Object?> get props => [isoCode];


}