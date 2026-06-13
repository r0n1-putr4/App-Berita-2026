// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool status;
  String message;
  List<DataUser> dataUsers;

  UserModel({
    required this.status,
    required this.message,
    required this.dataUsers,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    dataUsers: List<DataUser>.from(json["dataUsers"].map((x) => DataUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "dataUsers": List<dynamic>.from(dataUsers.map((x) => x.toJson())),
  };
}

class DataUser {
  int id;
  String username;
  String email;
  String fullName;
  String gambar;
  String createdAt;
  String updatedAt;

  DataUser({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.gambar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    fullName: json["full_name"],
    gambar: json["gambar"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "full_name": fullName,
    "gambar": gambar,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
