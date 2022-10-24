// To parse this JSON data, do
//
//     final encrypt = encryptFromJson(jsonString);

import 'dart:convert';

Encrypt encryptFromJson(String str) => Encrypt.fromJson(json.decode(str));

String encryptToJson(Encrypt data) => json.encode(data.toJson());

class Encrypt {
  Encrypt({
   required this.body,
   required this.statusCodeValue,
  required  this.statusCode,
  });


  Body body;
  int statusCodeValue;
  String statusCode;

  factory Encrypt.fromJson(Map<dynamic, dynamic> json) => Encrypt(
    body: Body.fromJson(json["body"]),
    statusCodeValue: json["statusCodeValue"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "body": body.toJson(),
    "statusCodeValue": statusCodeValue,
    "statusCode": statusCode,
  };
}

class Body {
  Body({
   required this.timeStamp,
   required this.status,
  required  this.message,
  required  this.data,
  });

  int timeStamp;
  bool status;
  String message;
  String data;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    timeStamp: json["timeStamp"],
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "timeStamp": timeStamp,
    "status": status,
    "message": message,
    "data": data,
  };
}


