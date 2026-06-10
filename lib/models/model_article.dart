// To parse this JSON data, do
//
//     final modelArticle = modelArticleFromJson(jsonString);

import 'dart:convert';

ModelArticle modelArticleFromJson(String str) => ModelArticle.fromJson(json.decode(str));

String modelArticleToJson(ModelArticle data) => json.encode(data.toJson());

class ModelArticle {
  String message;
  bool status;
  List<DataArticle> dataArticles;

  ModelArticle({
    required this.message,
    required this.status,
    required this.dataArticles,
  });

  factory ModelArticle.fromJson(Map<String, dynamic> json) => ModelArticle(
    message: json["message"],
    status: json["status"],
    dataArticles: List<DataArticle>.from(json["dataArticles"].map((x) => DataArticle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "dataArticles": List<dynamic>.from(dataArticles.map((x) => x.toJson())),
  };
}

class DataArticle {
  int id;
  String judul;
  String isi;
  String gambar;
  String user;
  String createdAt;
  String updatedAt;

  DataArticle({
    required this.id,
    required this.judul,
    required this.isi,
    required this.gambar,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataArticle.fromJson(Map<String, dynamic> json) => DataArticle(
    id: json["id"],
    judul: json["judul"],
    isi: json["isi"],
    gambar: json["gambar"],
    user: json["user"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "isi": isi,
    "gambar": gambar,
    "user": user,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
