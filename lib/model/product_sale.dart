// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<ProductSale> productFromJson(String str) {
    final jsonData = json.decode(str);
    return new List<ProductSale>.from(jsonData.map((x) => ProductSale.fromJson(x)));
}

String productToJson(List<ProductSale> data) {
    final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
    return json.encode(dyn);
}

class ProductSale {
    int? id;
    String? productName;
    String? paracode;
    int? price;
    int? quantity;
    int? purchaseId;
    String? expiryDate;
    String? createdAt;
    String? updatedAt;

    ProductSale({
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

    factory ProductSale.fromJson(Map<String, dynamic> json) => new ProductSale(
        id: json["id"]??0,
        productName: json["product_name"]??'',
        paracode: json["paracode"]??'',
        price: json["price"]??0,
        quantity: json["quantity"]??0,
        purchaseId: json["purchase_id"]??0,
        expiryDate: json["expiry_date"]??'',
        createdAt: json["created_at"]??'',
        updatedAt: json["updated_at"]??'',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "paracode": paracode,
        "price": price,
        "quantity": quantity,
        "purchase_id": purchaseId,
        "expiry_date": expiryDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
