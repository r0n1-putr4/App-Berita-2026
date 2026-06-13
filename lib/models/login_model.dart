// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool status;
  String message;
  DataLogin? dataLogin;

  LoginModel({
    required this.status,
    required this.message,
    this.dataLogin,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    dataLogin: json["dataLogin"] != null ? DataLogin.fromJson(json["dataLogin"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    if(dataLogin != null)  "dataLogin" : dataLogin!.toJson(),
  };
}

class DataLogin {
  int id;
  String username;
  String email;
  String full_name;
  String gambar;

  DataLogin({
    required this.id,
    required this.username,
    required this.email,
    required this.full_name,
    required this.gambar,
  });

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    full_name: json["full_name"],
    gambar: json["gambar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "full_name": full_name,
    "gambar": gambar,
  };
}
