class AllDonation {
  List<Data>? data;

  AllDonation({this.data});

  AllDonation.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? productName;
  String? paracode;
  int? quantity;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.productName,
      this.paracode,
      this.quantity,
      this.expiryDate,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    paracode = json['paracode'];
    quantity = json['quantity'];
    expiryDate = json['expiry_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['paracode'] = this.paracode;
    data['quantity'] = this.quantity;
    data['expiry_date'] = this.expiryDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
