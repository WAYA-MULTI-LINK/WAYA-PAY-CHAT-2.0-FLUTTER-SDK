// To parse this JSON data, do
//
//     final ussdPayload = ussdPayloadFromJson(jsonString);

import 'dart:convert';

UssdPayload ussdPayloadFromJson(String str) => UssdPayload.fromJson(json.decode(str));

String ussdPayloadToJson(UssdPayload data) => json.encode(data.toJson());

class UssdPayload {
  UssdPayload({
  required  this.amount,
    required  this.bankId,
    required  this.channel,
    required   this.customerEmail,
    required   this.customerId,
    required  this.merchantId,
    required  this.paymentDescription,
    required   this.subMerchantName,
    required  this.transactionReference,
    required  this.transactionType,
    required   this.transactionRefNo,
  });

  int amount;
  String bankId;
  String channel;
  String customerEmail;
  String customerId;
  String merchantId;
  String paymentDescription;
  String subMerchantName;
  int transactionReference;
  int transactionType;
  String transactionRefNo;

  factory UssdPayload.fromJson(Map<String, dynamic> json) => UssdPayload(
    amount: json["amount"],
    bankId: json["bankId"],
    channel: json["channel"],
    customerEmail: json["customerEmail"],
    customerId: json["customerId"],
    merchantId: json["merchantId"],
    paymentDescription: json["paymentDescription"],
    subMerchantName: json["subMerchantName"],
    transactionReference: json["transactionReference"],
    transactionType: json["transactionType"],
    transactionRefNo: json["transactionRefNo"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "bankId": bankId,
    "channel": channel,
    "customerEmail": customerEmail,
    "customerId": customerId,
    "merchantId": merchantId,
    "paymentDescription": paymentDescription,
    "subMerchantName": subMerchantName,
    "transactionReference": transactionReference,
    "transactionType": transactionType,
    "transactionRefNo": transactionRefNo,
  };
}
