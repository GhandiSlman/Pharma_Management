// To parse this JSON data, do
//
//     final purchases = purchasesFromJson(jsonString);

import 'dart:convert';

Purchases purchasesFromJson(String str) => Purchases.fromJson(json.decode(str));

String purchasesToJson(Purchases data) => json.encode(data.toJson());

class Purchases {
    List<Datum> data;
  //  Links links;
  //  Meta meta;

    Purchases({
        required this.data,
    //    required this.links,
      //  required this.meta,
    });

    factory Purchases.fromJson(Map<String, dynamic> json) => Purchases(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    //    links: Links.fromJson(json["links"]),
     //   meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
     //   "links": links.toJson(),
     //   "meta": meta.toJson(),
    };
}
Datum datumFromJson(String str) => Datum.fromJson(json.decode(str));
class Datum {
    Type type;
    Attributes attributes;

    Datum({
        required this.type,
        required this.attributes,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: typeValues.map[json["type"]]!,
        attributes: Attributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "attributes": attributes.toJson(),
    };
}
Attributes attributesFromJson(String str) => Attributes.fromJson(json.decode(str));

class Attributes {
    int id;
    String name;
    int categoryId;
    int supplierId;
    int netPrice;
    int sallingPrice;
    int quantity;
    DateTime expiryDate;
    dynamic image;

    Attributes({
        required this.id,
        required this.name,
        required this.categoryId,
        required this.supplierId,
        required this.netPrice,
        required this.sallingPrice,
        required this.quantity,
        required this.expiryDate,
        this.image,
    });

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        supplierId: json["supplier_id"],
        netPrice: json["net_price"],
        sallingPrice: json["salling_price"],
        quantity: json["quantity"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        image: json["image"]??'https://images.unsplash.com/photo-1555633514-9433624af83a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "supplier_id": supplierId,
        "net_price": netPrice,
        "salling_price": sallingPrice,
        "quantity": quantity,
        "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "image": image,
    };
}

enum Type { PURCHASES }

final typeValues = EnumValues({
    "purchases": Type.PURCHASES
});

// class Links {
//     String? first;
//     String? last;
//     dynamic prev;
//     String? next;

//     Links({
//          this.first,
//          this.last,
//         this.prev,
//          this.next,
//     });

//     factory Links.fromJson(Map<String, dynamic> json) => Links(
//         first: json["first"],
//         last: json["last"],
//         prev: json["prev"],
//         next: json["next"],
//     );

//     Map<String, dynamic> toJson() => {
//         "first": first,
//         "last": last,
//         "prev": prev,
//         "next": next,
//     };
// }

// class Meta {
//     int? currentPage;
//     int? from;
//     int? lastPage;
//     List<Link>? links;
//     String? path;
//     int? perPage;
//     int? to;
//     int? total;

//     Meta({
//          this.currentPage,
//          this.from,
//          this.lastPage,
//          this.links,
//          this.path,
//          this.perPage,
//          this.to,
//          this.total,
//     });

//     factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         currentPage: json["current_page"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
//         path: json["path"],
//         perPage: json["per_page"],
//         to: json["to"],
//         total: json["total"],
//     );

//     Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "from": from,
//         "last_page": lastPage,
//         "links": List<dynamic>.from(links!.map((x) => x.toJson())),
//         "path": path,
//         "per_page": perPage,
//         "to": to,
//         "total": total,
//     };
// }

// class Link {
//     String? url;
//     String? label;
//     bool? active;

//     Link({
//         this.url,
//          this.label,
//          this.active,
//     });

//     factory Link.fromJson(Map<String, dynamic> json) => Link(
//         url: json["url"],
//         label: json["label"],
//         active: json["active"],
//     );

//     Map<String, dynamic> toJson() => {
//         "url": url,
//         "label": label,
//         "active": active,
//     };
// }

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
