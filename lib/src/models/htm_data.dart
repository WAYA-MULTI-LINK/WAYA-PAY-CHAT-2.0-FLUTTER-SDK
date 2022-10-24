// To parse this JSON data, do
//
//     final htmlData = htmlDataFromJson(jsonString);

import 'dart:convert';

HtmlData htmlDataFromJson(String str) => HtmlData.fromJson(json.decode(str));

String htmlDataToJson(HtmlData data) => json.encode(data.toJson());

class HtmlData {
  HtmlData({
  required  this.timeStamp,
    required   this.status,
    required  this.message,
    required   this.data,
  });

  int timeStamp;
  bool status;
  String message;
  Data data;

  factory HtmlData.fromJson(Map<dynamic, dynamic> json) => HtmlData(
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
    required  this.callbackResponse,
    required   this.callbackUrl,
  });

  String callbackResponse;
  String callbackUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    callbackResponse: json["callbackResponse"],
    callbackUrl: json["callbackUrl"],
  );

  Map<String, dynamic> toJson() => {
    "callbackResponse": callbackResponse,
    "callbackUrl": callbackUrl,
  };
}
