// To parse this JSON data, do
//
//     final qrCodeData = qrCodeDataFromJson(jsonString);

import 'dart:convert';

QrCodeData qrCodeDataFromJson(String str) => QrCodeData.fromJson(json.decode(str));

String qrCodeDataToJson(QrCodeData data) => json.encode(data.toJson());

class QrCodeData {
  QrCodeData({
   required this.timeStamp,
    required this.status,
    required  this.message,
    required  this.data,
  });

  int timeStamp;
  bool status;
  String message;
  Data data;

  factory QrCodeData.fromJson(Map<dynamic, dynamic> json) => QrCodeData(
    timeStamp: json["timeStamp"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "timeStamp": timeStamp,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required  this.headers,
    required  this.body,
    required  this.statusCodeValue,
    required this.statusCode,
    required this.name,
  });

  Headers headers;
  String body;
  int statusCodeValue;
  String statusCode;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    headers: Headers.fromJson(json["headers"]),
    body: json["body"],
    statusCodeValue: json["statusCodeValue"],
    statusCode: json["statusCode"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "headers": headers.toJson(),
    "body": body,
    "statusCodeValue": statusCodeValue,
    "statusCode": statusCode,
    "name": name,
  };
}

class Headers {
  Headers({
    required  this.contentType,
  });

  List<String> contentType;

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
    contentType: List<String>.from(json["Content-Type"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Content-Type": List<dynamic>.from(contentType.map((x) => x)),
  };
}
