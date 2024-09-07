// To parse this JSON data, do
//
//     final errorProductModel = errorProductModelFromJson(jsonString);

import 'dart:convert';

import 'respone_model.dart';

ErrorModel errorProductModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorProductModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel extends ResponeModel {
  String status;
  String code;
  String message;

  @override
  String getStatus() => status;

  ErrorModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
