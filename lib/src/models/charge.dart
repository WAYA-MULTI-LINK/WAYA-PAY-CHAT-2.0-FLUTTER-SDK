// To parse this JSON data, do
//
//     final charge = chargeFromJson(jsonString);

import 'dart:convert';

Charge chargeFromJson(String str) => Charge.fromJson(json.decode(str));

String chargeToJson(Charge data) => json.encode(data.toJson());

class Charge {
  Charge({
   required this.amount,
    required this.description,
   this.currency = "566",
    this.fee = 0,
     this.deviceInformation,
    required this.customer,
    required this.merchantId,
    required this.wayaPublicKey,
    required this.isTest
  });

  double amount;
  String description;
  String currency;
  int fee;
  bool isTest;
  String? deviceInformation;
  Customer customer;
  String merchantId;
  String wayaPublicKey;

  Charge copyWith({
    double? amount,
    String? description,
    String? currency,
    int? fee,
    String? deviceInformation,
    Customer? customer,
    String? merchantId,
    String? wayaPublicKey,
  }) =>
      Charge(
        isTest: isTest??isTest,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        currency: currency ?? this.currency,
        fee: fee ?? this.fee,
        deviceInformation: deviceInformation ?? this.deviceInformation,
        customer: customer ?? this.customer,
        merchantId: merchantId ?? this.merchantId,
        wayaPublicKey: wayaPublicKey ?? this.wayaPublicKey,
      );

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
    amount: json["amount"],
    description: json["description"],
    currency: json["currency"],
    fee: json["fee"],
    deviceInformation: json["deviceInformation"],
    customer: Customer.fromJson(json["customer"]),
    merchantId: json["merchantId"],
    wayaPublicKey: json["wayaPublicKey"],
    isTest: true
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "description": description,
    "currency": currency,
    "fee": fee,
    "deviceInformation": deviceInformation,
    "customer": customer.toJson(),
    "merchantId": merchantId,
    "wayaPublicKey": wayaPublicKey,
  };
}

class Customer {
  Customer({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  String name;
  String email;
  String phoneNumber;

  Customer copyWith({
    String? name,
    String? email,
    String? phoneNumber,
  }) =>
      Customer(
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}
