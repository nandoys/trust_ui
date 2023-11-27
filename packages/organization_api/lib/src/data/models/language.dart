import 'package:equatable/equatable.dart';

class Language extends Equatable {
  Language({required this.id, required this.name});

  final String id;
  final String name;

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(id: json['id'], name: json['name']);
  }

  @override
  List<Object?> get props => [name];

}