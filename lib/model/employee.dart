// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
    List<Datum> data;

    Employee({
        required this.data,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
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
    String name;
    String email;
    String phone;
    DateTime startDate;
    DateTime birthdate;
    String salary;

    Attributes({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.startDate,
        required this.birthdate,
        required this.salary,
    });

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        startDate: DateTime.parse(json["start_date"]),
        birthdate: DateTime.parse(json["birthdate"]),
        salary: json["salary"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "salary": salary,
    };
}
