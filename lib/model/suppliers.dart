// To parse this JSON data, do
//
//     final suppliers = suppliersFromJson(jsonString);

import 'dart:convert';

Suppliers suppliersFromJson(String str) => Suppliers.fromJson(json.decode(str));

String suppliersToJson(Suppliers data) => json.encode(data.toJson());

class Suppliers {
  List<Datum> data;

  Suppliers({
    required this.data,
  });

  factory Suppliers.fromJson(Map<String, dynamic> json) => Suppliers(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String type;
  Attributes attributes;

  Datum({
    required this.type,
    required this.attributes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  int id;
  String? name;
  String? email;
  String? phone;
  String? company;
  String? address;
  String? description;

  Attributes({
    required this.id,
     this.name,
     this.email,
     this.phone,
     this.company,
     this.address,
     this.description,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id:json["id"],
        name: json["name"],
        email: json["email"] ?? '',
        phone: json["phone"],
        company: json["company"],
        address: json["address"]?? '',
        description: json["description"]?? '',
      );

  Map<String, dynamic> toJson() => {
        "id":id,
        "name": name,
        "email": email,
        "phone": phone,
        "company": company,
        "address": address,
        "description": description,
      };
}
