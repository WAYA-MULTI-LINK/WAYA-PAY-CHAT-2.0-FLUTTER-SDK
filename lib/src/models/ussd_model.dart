// To parse this JSON data, do
//
//     final ussd = ussdFromJson(jsonString);

import 'dart:convert';

Ussd ussdFromJson(String str) => Ussd.fromJson(json.decode(str));

String ussdToJson(Ussd data) => json.encode(data.toJson());

class Ussd {
  Ussd({
   required this.code,
  required  this.message,
  required  this.data,
  required  this.date,
  });

  String code;
  String message;
  Data data;
  DateTime date;

  factory Ussd.fromJson(Map<dynamic, dynamic> json) => Ussd(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
    "date": date.toIso8601String(),
  };
}

class Data {
  Data({
  required  this.mode,
  required  this.responseHeader,
  required  this.responseDetails,
  });

  String mode;
  ResponseHeader responseHeader;
  ResponseDetails responseDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mode: json["mode"],
    responseHeader: ResponseHeader.fromJson(json["responseHeader"]),
    responseDetails: ResponseDetails.fromJson(json["responseDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "mode": mode,
    "responseHeader": responseHeader.toJson(),
    "responseDetails": responseDetails.toJson(),
  };
}

class ResponseDetails {
  ResponseDetails({
  required  this.reference,
  required  this.traceId,
  required  this.timeStamp,
  required  this.amount,
  required  this.transactionId,
  required  this.ussdString,
  });

  String reference;
  String traceId;
  num timeStamp;
  num amount;
  String transactionId;
  String ussdString;

  factory ResponseDetails.fromJson(Map<String, dynamic> json) => ResponseDetails(
    reference: json["reference"],
    traceId: json["traceId"],
    timeStamp: json["timeStamp"],
    amount: json["amount"],
    transactionId: json["transactionId"],
    ussdString: json["ussdString"],
  );

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "traceId": traceId,
    "timeStamp": timeStamp,
    "amount": amount,
    "transactionId": transactionId,
    "ussdString": ussdString,
  };
}

class ResponseHeader {
  ResponseHeader({
   required this.responseCode,
  required  this.responseMessage,
  });

  String responseCode;
  String responseMessage;

  factory ResponseHeader.fromJson(Map<String, dynamic> json) => ResponseHeader(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
  };
}
