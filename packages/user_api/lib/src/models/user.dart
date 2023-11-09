import 'package:equatable/equatable.dart';
import 'package:organisation_api/organisation_api.dart';

class User extends Equatable {
  const User({this.id, required this.username, required this.email, this.password, required this.organisation});

  factory User.fromJson(Map<String, dynamic> json) {
    final organisation = Organisation.fromJson(json['organisation']);

    return User(username: json['username'], email: json['email'], organisation: organisation);
  }

  final String? id;
  final String username;
  final String email;
  final String? password;
  final Organisation organisation;

  Map<String, dynamic> toJson() {
    Map<String, dynamic>  data = {'username': username, 'email': email, 'password': password, 'org_id': organisation.id};

    return data;

  }

  @override
  List<Object> get props => [username];
}