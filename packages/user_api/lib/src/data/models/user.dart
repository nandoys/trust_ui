import 'package:equatable/equatable.dart';
import 'package:organisation_api/organisation_api.dart';

class User extends Equatable {
  const User({this.id, required this.username, required this.email, this.password, required this.organisation,
    this.accessToken, this.refreshToken,});

  factory User.fromJson(Map<String, dynamic> json) {
    final organisation = Organisation.fromJson(json['user']['organisation']);
    return User(
        username: json['user']['username'],
        email: json['user']['email'],
        organisation: organisation,
        accessToken: json['access'],
        refreshToken: json['refresh']
    );
  }

  final String? id;
  final String username;
  final String email;
  final String? password;
  final Organisation organisation;
  final String? accessToken;
  final String? refreshToken;

  Map<String, dynamic> toJson() {
    Map<String, dynamic>  data = {'username': username, 'email': email, 'password': password, 'org_id': organisation.id};

    return data;

  }

  @override
  List<Object> get props => [username];
}