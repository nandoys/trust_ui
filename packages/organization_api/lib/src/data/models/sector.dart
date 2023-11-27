part of 'organization.dart';


class Sector extends Equatable {
  Sector({required this.id, required this.name});

  final String id;
  final String name;
  
  factory Sector.fromJson(Map<String, dynamic> json) {
    return Sector(id: json['id'], name: json['name']);
  }

  @override
  List<Object?> get props => [id];

}