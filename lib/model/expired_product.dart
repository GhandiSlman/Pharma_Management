// To parse this JSON data, do
//
//     final expiredProduct = expiredProductFromJson(jsonString);

import 'dart:convert';

List<ExpiredProduct> expiredProductFromJson(String str) => List<ExpiredProduct>.from(json.decode(str).map((x) => ExpiredProduct.fromJson(x)));

String expiredProductToJson(List<ExpiredProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpiredProduct {
    String? productName;
    int? price;
    String? paracode;
    String? expiryDate;
    int? quantity;

    ExpiredProduct({
         this.productName,
         this.price,
         this.paracode,
         this.expiryDate,
         this.quantity,
    });

    factory ExpiredProduct.fromJson(Map<String, dynamic> json) => ExpiredProduct(
        productName: json["product_name"],
        price: json["price"],
        paracode: json["paracode"],
        expiryDate: json["expiry_date"],
        quantity: json["quantity"] 
    );

    Map<String, dynamic> toJson() => {
        "product_name": productName,
        "price": price,
        "paracode": paracode,
        "expiry_date": expiryDate,
        "quantity": quantity,
    };
}
