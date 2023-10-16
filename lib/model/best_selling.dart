// To parse this JSON data, do
//
//     final bestSelling = bestSellingFromJson(jsonString);

import 'dart:convert';

List<BestSelling> bestSellingFromJson(String str) => List<BestSelling>.from(json.decode(str).map((x) => BestSelling.fromJson(x)));

String bestSellingToJson(List<BestSelling> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BestSelling {
    int productId;
    String productName;
    int quantity;
    int price;
    String selling_quantity;

    BestSelling({
        required this.productId,
        required this.productName,
        required this.quantity,
        required this.price,
        required this.selling_quantity,
    });

    factory BestSelling.fromJson(Map<String, dynamic> json) => BestSelling(
        productId: json["product_id"] ??'',
        productName: json["product_name"] ??'',
        quantity: json["quantity"] ??'',
        price: json["price"]?? '',
        selling_quantity: json["selling_quantity"]??'' 
        
        ,
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "price": price,
        "selling_quantity": selling_quantity,
    };
}
