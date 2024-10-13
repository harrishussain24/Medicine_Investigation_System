import 'dart:convert';

NotifyModel welcomeFromJson(String str) =>
    NotifyModel.fromJson(json.decode(str));

String welcomeToJson(NotifyModel data) => json.encode(data.toJson());

class NotifyModel {
  NotifyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.date,
    required this.time,
  });

  String? id;
  String? name;
  String? email;
  String? message;
  String? date;
  String? time;

  factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        message: json["message"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "message": message,
        "date": date,
        "time": time,
      };
}
