// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

CustomerCharge customerFromJson(String str) =>
    CustomerCharge.fromJson(json.decode(str));

String customerToJson(CustomerCharge data) => json.encode(data.toJson());

class CustomerCharge {
  String timeStamp;
  bool status;
  String message;
  Data data;
  CustomerCharge({
    required this.timeStamp,
    required this.status,
    required this.message,
    required this.data,
  });

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

  @override
  String toString() {
    return 'CustomerCharge(timeStamp: $timeStamp, status: $status, message: $message, data: $data)';
  }
}

class Data {
  String tranId;
  String name;
  String customerId;
  bool customerAvoid;
  Data({
    required this.tranId,
    required this.name,
    required this.customerId,
    required this.customerAvoid,
  });

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

  @override
  String toString() {
    return 'Data(tranId: $tranId, name: $name, customerId: $customerId, customerAvoid: $customerAvoid)';
  }
}
