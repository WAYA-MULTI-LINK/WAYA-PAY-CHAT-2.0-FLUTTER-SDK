// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

CustomerCharge customerFromJson(String str) => CustomerCharge.fromJson(json.decode(str));

String customerToJson(CustomerCharge data) => json.encode(data.toJson());

class CustomerCharge {
  CustomerCharge({
   required this.timeStamp,
    required this.status,
    required this.message,
    required this.data,
  });

  int timeStamp;
  bool status;
  String message;
  Data data;

  factory CustomerCharge.fromJson(Map<dynamic, dynamic> json) => CustomerCharge(
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
    required this.tranId,
    required  this.name,
    required this.customerId,
    required  this.customerAvoid,
  });

  String tranId;
  String name;
  String customerId;
  bool customerAvoid;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tranId: json["tranId"],
    name: json["name"],
    customerId: json["customerId"],
    customerAvoid: json["customerAvoid"],
  );

  Map<String, dynamic> toJson() => {
    "tranId": tranId,
    "name": name,
    "customerId": customerId,
    "customerAvoid": customerAvoid,
  };
}
