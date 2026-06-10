// To parse this JSON data, do
//
//     final modelResponse = modelResponseFromJson(jsonString);

import 'dart:convert';

ModelResponse modelResponseFromJson(String str) => ModelResponse.fromJson(json.decode(str));

String modelResponseToJson(ModelResponse data) => json.encode(data.toJson());

class ModelResponse {
  bool status;
  String message;

  ModelResponse({
    required this.status,
    required this.message,
  });

  factory ModelResponse.fromJson(Map<String, dynamic> json) => ModelResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
