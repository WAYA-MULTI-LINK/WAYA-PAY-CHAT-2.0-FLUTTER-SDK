// To parse this JSON data, do
//
//     final cardProcessData = cardProcessDataFromJson(jsonString);

import 'dart:convert';

CardProcessData cardProcessDataFromJson(String str) => CardProcessData.fromJson(json.decode(str));

String cardProcessDataToJson(CardProcessData data) => json.encode(data.toJson());

class CardProcessData {
  CardProcessData({
   required this.cardholder,
    required this.encryptCardNo,
    required this.expiry,
    required this.mobile,
    required this.pin,
    required this.deviceInformation,
    required  this.tranId,
    required this.scheme,
    required this.wayaPublicKey,
  });

  String cardholder;
  String encryptCardNo;
  String expiry;
  String mobile;
  String pin;
  String deviceInformation;
  String tranId;
  String scheme;
  String wayaPublicKey;

  factory CardProcessData.fromJson(Map<String, dynamic> json) => CardProcessData(
    cardholder: json["cardholder"],
    encryptCardNo: json["encryptCardNo"],
    expiry: json["expiry"],
    mobile: json["mobile"],
    pin: json["pin"],
    deviceInformation: json["deviceInformation"],
    tranId: json["tranId"],
    scheme: json["scheme"],
    wayaPublicKey: json["wayaPublicKey"],
  );

  Map<String, dynamic> toJson() => {
    "cardholder": cardholder,
    "encryptCardNo": encryptCardNo,
    "expiry": expiry,
    "mobile": mobile,
    "pin": pin,
    "deviceInformation": deviceInformation,
    "tranId": tranId,
    "scheme": scheme,
    "wayaPublicKey": wayaPublicKey,
  };
}
