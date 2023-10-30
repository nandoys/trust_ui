import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:trust_app/utils.dart';

@immutable
class Organisation extends Equatable {
  const Organisation({required this.name, required this.pays, required this.typeOrganisation, this.id, this.address,
    this.activities, this.email, this.telephone, this.logo, this.registre, this.idNat, this.numeroImpot,
    this.numeroSocial, this.numeroEmployeur });

  final String? id;
  final String name;
  final String? address;
  final Map<String, String> pays;
  final List<Activity>? activities;
  final String? email;
  final String? telephone;
  final String? logo;
  final TypeOrganisation typeOrganisation;
  final String? registre;
  final String? idNat;
  final String? numeroImpot;
  final String? numeroSocial;
  final String? numeroEmployeur;

  @override
  List<Object?> get props => [id];
}

class TypeOrganisation implements ModelLayer{
  TypeOrganisation({required this.id, required this.name});

  final String id;
  final String name;

  @override
  Future creaData(host) {
    // TODO: implement creaData
    throw UnimplementedError();
  }

  @override
  Future deleteData(host) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future readData(host) {
    // TODO: implement readData
    throw UnimplementedError();
  }

  @override
  Future updateData(host) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}

class Country implements ModelLayer {
  Country({required this.id, required this.name, required this.phoneCode, required this.currency,
    required this.languages});

  // factory Country.fromJson(Map<String, dynamic> json) {
  //   Currency currency = Currency(name: json['monnaie_locale']['intitule'],
  //       symbol: json['monnaie_locale']['symbole'], codeIso: json['monnaie_locale']['code_iso'],
  //       unit: json['monnaie_locale']['unite']);
  //
  //   return Country(
  //     id: json['id'],
  //     name: json['nom'],
  //     phoneCode: json['indicatif'],
  //
  //   );
  // }

  final String id;
  final String name;
  final String phoneCode;
  final List<Currency> currency;
  final List<Language> languages;

  @override
  Future creaData(host) {
    throw UnimplementedError();
  }

  @override
  Future deleteData(host) {
    throw UnimplementedError();
  }

  @override
  Future readData(host) async {
    var request = await http.get(
      Uri.http(host, '/api/organisation/pays/'),
    );
    return jsonDecode(utf8.decode(request.bodyBytes));
  }

  @override
  Future updateData(host) {
    throw UnimplementedError();
  }
}

class Currency implements ModelLayer {
  Currency({required this.id, required this.name, required this.symbol, required this.codeIso, required this.unit});

  final String id;
  final String name;
  final String symbol;
  final String codeIso;
  final double unit;

  @override
  Future creaData(host) {
    // TODO: implement creaData
    throw UnimplementedError();
  }

  @override
  Future deleteData(host) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  static Future readAllData(host) async {
    var request = await http.get(
      Uri.http(host, '/api/parametres/devises/'),
    );
    return jsonDecode(utf8.decode(request.bodyBytes));
  }

  @override
  Future readData(host) async {
    var request = await http.get(
      Uri.http(host, '/api/parametres/devises/'),
    );
    return jsonDecode(utf8.decode(request.bodyBytes));
  }

  @override
  Future updateData(host) {
    // TODO: implement updateData
    throw UnimplementedError();
  }

}

class Language implements ModelLayer {
  Language({required this.id, required this.name});

  final String id;
  final String name;

  @override
  Future creaData(host) {
    // TODO: implement creaData
    throw UnimplementedError();
  }

  @override
  Future deleteData(host) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Future readData(host) {
    // TODO: implement readData
    throw UnimplementedError();
  }

  @override
  Future updateData(host) {
    // TODO: implement updateData
    throw UnimplementedError();
  }

}

class Activity implements ModelLayer {
  Activity({required this.id, required this.name});

  final String id;
  final String name;

  @override
  Future creaData(host) {
    throw UnimplementedError();
  }

  @override
  Future deleteData(host) {
    throw UnimplementedError();
  }

  @override
  Future readData(host) {
    throw UnimplementedError();
  }

  @override
  Future updateData(host) {
    throw UnimplementedError();
  }

}