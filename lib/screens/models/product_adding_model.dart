// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProductModel welcomeFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String welcomeToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.id,
    required this.unique_id,
    required this.batch_no,
    required this.medicine_name,
    required this.mfg_date,
    required this.exp_date,
    required this.registration_no,
    required this.price,
    required this.barcode_no,
    required this.qrcode_no,
  });

  String? id;
  String? unique_id;
  String? batch_no;
  String? medicine_name;
  String? mfg_date;
  String? exp_date;
  String? registration_no;
  String? price;
  String? barcode_no;
  String? qrcode_no;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        unique_id: json["unique_id"],
        batch_no: json["batch_no"],
        medicine_name: json["medicine_name"],
        mfg_date: json["mfg_date"],
        exp_date: json["exp_date"],
        registration_no: json["registration_no"],
        price: json["price"],
        barcode_no: json["barcode_no"],
        qrcode_no: json["qrcode_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": unique_id,
        "batch_no": batch_no,
        "medicine_name": medicine_name,
        "mfg_date": mfg_date,
        "exp_date": exp_date,
        "registration_no": registration_no,
        "price": price,
        "barcode_no": barcode_no,
        "qrcode_no": qrcode_no,
      };
}
