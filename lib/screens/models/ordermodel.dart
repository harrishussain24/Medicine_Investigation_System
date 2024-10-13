import 'dart:convert';

OrderModel welcomeFromJson(String str) => OrderModel.fromJson(json.decode(str));

String welcomeToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    required this.id,
    required this.data,
    required this.date,
    required this.time,
    required this.email,
  });

  String? id;
  String? data;
  String? date;
  String? time;
  String? email;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        data: json["data"],
        date: json["date"],
        time: json["time"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data,
        "date": date,
        "time": time,
        "email": email,
      };
}
