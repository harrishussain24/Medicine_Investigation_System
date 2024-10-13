import 'dart:convert';

Products welcomeFromJson(String str) => Products.fromJson(json.decode(str));

String welcomeToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    required this.P_ID,
    required this.Unique_ID,
    required this.Batch_No,
    required this.Medicine_Name,
    required this.Mfg_Date,
    required this.Exp_Date,
    required this.Registration_No,
    required this.Price,
    required this.Barcode_No,
    required this.QRcode_No,
  });

  final String P_ID;
  final String Unique_ID;
  final String Batch_No;
  final String Medicine_Name;
  final String Mfg_Date;
  final String Exp_Date;
  final String Registration_No;
  final String Price;
  final String Barcode_No;
  final String QRcode_No;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        P_ID: json["P_ID"],
        Unique_ID: json["Unique_ID"],
        Batch_No: json["Batch_No"],
        Medicine_Name: json["Medicine_Name"],
        Mfg_Date: json["Mfg_Date"],
        Exp_Date: json["Exp_Date"],
        Registration_No: json["Registration_No"],
        Price: json["Price"],
        Barcode_No: json["Barcode_No"],
        QRcode_No: json["QRcode_No"],
      );

  Map<String, dynamic> toJson() => {
        "P_ID": P_ID,
        "Unique_ID": Unique_ID,
        "Batch_No": Batch_No,
        "Medicine_Name": Medicine_Name,
        "Mfg_Date": Mfg_Date,
        "Exp_Date": Exp_Date,
        "Registration_No": Registration_No,
        "Price": Price,
        "Barcode_No": Barcode_No,
        "QRcode_No": QRcode_No,
      };
}
