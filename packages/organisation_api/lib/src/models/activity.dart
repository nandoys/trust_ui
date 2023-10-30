part of 'organisation.dart';


class Activity extends Equatable {
  Activity({required this.id, required this.name});

  final String id;
  final String name;
  
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(id: json['id'], name: json['intitule']);
  }

  @override
  List<Object?> get props => [id];

}