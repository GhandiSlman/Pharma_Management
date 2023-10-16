class AllDebt {
  List<Data>? data;

  AllDebt({this.data});

  AllDebt.fromJson(Map<String, dynamic> json) {
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
  String? customerName;
  int? debtValue;
  int? invoiceId;
  String? debtDate;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.customerName,
      this.debtValue,
      this.invoiceId,
      this.debtDate,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    debtValue = json['debt_value'];
    invoiceId = json['invoice_id'];
    debtDate = json['debt_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['debt_value'] = this.debtValue;
    data['invoice_id'] = this.invoiceId;
    data['debt_date'] = this.debtDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
