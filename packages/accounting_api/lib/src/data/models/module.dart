import 'package:accounting_api/accounting_api.dart';
import 'package:equatable/equatable.dart';

class Module extends Equatable {

  Module({required this.id, required this.name, required this.account});

  final String id;
  final String name;
  final Account account;

  @override
  List<Object?> get props => [id];

}