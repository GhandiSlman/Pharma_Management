// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  List<Datum>? data;

  Categories({
    this.data,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
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
  String name;
  int id;

  Attributes({
    required this.name,
    required this.id,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        id:json["id"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id":id,
      };
}
