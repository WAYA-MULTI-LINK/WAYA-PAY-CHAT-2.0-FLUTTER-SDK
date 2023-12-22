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
    required this.merchantId,
    required this.securityCode,
    this.recurrent = false
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
  String merchantId;
  String securityCode;
  bool recurrent;

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
    securityCode:  json["securityCode"],
    merchantId: json["merchantId"],
  );

  Map<String, dynamic> toJson() => {
    "cardholder": cardholder,
    "encryptCardNo": encryptCardNo,
    "expiry": expiry,
    "mobile": mobile,
    "pin": pin,
    "recurrentPayment":false,
    "tranId": tranId,
    "scheme": scheme,
    "wayaPublicKey": wayaPublicKey,
    "merchantId":merchantId,
    "securityCode":securityCode
  };
}
