import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.userEmail,
    this.pin,
  });

  String? userEmail;
  String? pin;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userEmail: json["userEmail"],
    pin: json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "userEmail": userEmail,
    "pin": pin,
  };
}
