// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserModel welcomeFromJson(String str) => UserModel.fromJson(json.decode(str));

String welcomeToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone_no,
    required this.CNIC,
    required this.address,
    required this.pharmacy_name,
    required this.pharmacy_reg_no,
    required this.password,
  });

  String? id;
  String? username;
  String? email;
  String? phone_no;
  String? CNIC;
  String? address;
  String? pharmacy_name;
  String? pharmacy_reg_no;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phone_no: json["phone_no"],
        CNIC: json["CNIC"],
        address: json["address"],
        pharmacy_name: json["pharmacy_name"],
        pharmacy_reg_no: json["pharmacy_reg_no"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone_no": phone_no,
        "CNIC": CNIC,
        "address": address,
        "pharmacy_name": pharmacy_name,
        "pharmacy_reg_no": pharmacy_reg_no,
        "password": password,
      };
}
