import 'dart:convert';
import 'package:flutter/foundation.dart' show immutable;
import 'package:jsonplaceholder_app/data/models/abstract_model.dart';

@immutable
class UserModel extends ItemModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  @override
  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: Address.fromMap(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company: Company.fromMap(json["company"]),
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toMap(),
        "phone": phone,
        "website": website,
        "company": company.toMap(),
      };

  @override
  String toString() {
    return toMap().toString();
  }
}

@immutable
class Address {
  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: Geo.fromMap(json["geo"]),
      );

  Map<String, dynamic> toMap() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo.toMap(),
      };

  @override
  String toString() {
    return toMap().toString();
  }
}

@immutable
class Geo {
  const Geo({
    required this.lat,
    required this.lng,
  });

  final String lat;
  final String lng;

  factory Geo.fromJson(String str) => Geo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geo.fromMap(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}

@immutable
class Company {
  const Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  final String name;
  final String catchPhrase;
  final String bs;

  factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}
