import 'package:equatable/equatable.dart';
import 'package:organization_api/organization_api.dart';

class User extends Equatable {
  const User({this.id, required this.username, required this.email, this.password, required this.organization,
    this.accessToken, this.refreshToken,});

  factory User.fromJson(Map<String, dynamic> json) {
    final organization = Organization.fromJson(json['user']['organization']);
    return User(
        username: json['user']['username'],
        email: json['user']['email'],
        organization: organization,
        accessToken: json['access'],
        refreshToken: json['refresh']
    );
  }

  final String? id;
  final String username;
  final String email;
  final String? password;
  final Organization organization;
  final String? accessToken;
  final String? refreshToken;

  Map<String, dynamic> toJson() {
    Map<String, dynamic>  data = {'username': username, 'email': email, 'password': password, 'org_id': organization.id};

    return data;

  }

  @override
  List<Object> get props => [username];
}