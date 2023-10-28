import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import 'package:trust_app/utils.dart';

class Organisation implements ModelLayer{
  Organisation({required this.id, required this.name, required this.pays, required this.typeOrganisation,
  this.address,  this.activities, this.email, this.telephone, this.logo, this.registre, this.idNat, this.numeroImpot,
    this.numeroSocial, this.numeroEmployeur });

  final String id;
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

class Pays implements ModelLayer {
  Pays({required this.id, required this.name, required this.phoneCode, required this.currency,
    required this.languages});

  final String id;
  final String name;
  final String phoneCode;
  final Currency currency;
  final List<Language> languages;

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

class Currency implements ModelLayer {
  Currency({required this.intitule, required this.symbol, required this.codeIso, required this.unit});
  final String intitule;
  final String symbol;
  final String codeIso;
  final Double unit;

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