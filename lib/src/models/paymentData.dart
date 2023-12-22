// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final paymentData = paymentDataFromJson(jsonString);

import 'dart:convert';

PaymentData paymentDataFromJson(String str) => PaymentData.fromJson(json.decode(str));

String paymentDataToJson(PaymentData data) => json.encode(data.toJson());

class PaymentData {
    DateTime? timeStamp;
    bool? status;
    String? message;
    Data? data;

    PaymentData({
        this.timeStamp,
        this.status,
        this.message,
        this.data,
    });

    PaymentData copyWith({
        DateTime? timeStamp,
        bool? status,
        String? message,
        Data? data,
    }) => 
        PaymentData(
            timeStamp: timeStamp ?? this.timeStamp,
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PaymentData.fromJson(Map<dynamic, dynamic> json) => PaymentData(
        timeStamp: json["timeStamp"] == null ? null : DateTime.parse(json["timeStamp"]),
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "timeStamp": timeStamp?.toIso8601String(),
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };

  @override
  String toString() {
    return 'PaymentData(timeStamp: $timeStamp, status: $status, message: $message, data: $data)';
  }
}

class Data {
    String? transactionId;
    String? cardType;
    String? processor;
    String? processorResponseCode;
    String? message;
    String? merchantRedirectUrl;

    Data({
        this.transactionId,
        this.cardType,
        this.processor,
        this.processorResponseCode,
        this.message,
        this.merchantRedirectUrl,
    });

    Data copyWith({
        String? transactionId,
        String? cardType,
        String? processor,
        String? processorResponseCode,
        String? message,
        String? merchantRedirectUrl,
    }) => 
        Data(
            transactionId: transactionId ?? this.transactionId,
            cardType: cardType ?? this.cardType,
            processor: processor ?? this.processor,
            processorResponseCode: processorResponseCode ?? this.processorResponseCode,
            message: message ?? this.message,
            merchantRedirectUrl: merchantRedirectUrl ?? this.merchantRedirectUrl,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json["transactionId"],
        cardType: json["cardType"],
        processor: json["processor"],
        processorResponseCode: json["processorResponseCode"],
        message: json["message"],
        merchantRedirectUrl: json["merchantRedirectUrl"],
    );

    Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "cardType": cardType,
        "processor": processor,
        "processorResponseCode": processorResponseCode,
        "message": message,
        "merchantRedirectUrl": merchantRedirectUrl,
    };

  @override
  String toString() {
    return 'Data(transactionId: $transactionId, cardType: $cardType, processor: $processor, processorResponseCode: $processorResponseCode, message: $message, merchantRedirectUrl: $merchantRedirectUrl)';
  }
}
