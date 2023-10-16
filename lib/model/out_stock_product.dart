// To parse this JSON data, do
//
//     final outStockProduct = outStockProductFromJson(jsonString);

import 'dart:convert';

List<OutStockProduct> outStockProductFromJson(String str) => List<OutStockProduct>.from(json.decode(str).map((x) => OutStockProduct.fromJson(x)));

String outStockProductToJson(List<OutStockProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OutStockProduct {
    int? id;
    String? productName;
    String? paracode;
    int? price;
    int? quantity;
    int? purchaseId;
    String? expiryDate;
    DateTime? createdAt;
    DateTime? updatedAt;

    OutStockProduct({
         this.id,
         this.productName,
         this.paracode,
         this.price,
         this.quantity,
         this.purchaseId,
        this.expiryDate,
         this.createdAt,
         this.updatedAt,
    });

    factory OutStockProduct.fromJson(Map<String, dynamic> json) => OutStockProduct(
        id: json["id"]??'',
        productName: json["product_name"]??'',
        paracode: json["paracode"]??'',
        price: json["price"]??'',
        quantity: json["quantity"]??'',
        purchaseId: json["purchase_id"]??'',
        expiryDate: json["expiry_date"]??'',
        createdAt: DateTime.parse(json["created_at"]??''),
        updatedAt: DateTime.parse(json["updated_at"]??''),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "paracode": paracode,
        "price": price,
        "quantity": quantity!,
        "purchase_id": purchaseId!,
        "expiry_date": expiryDate!,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
