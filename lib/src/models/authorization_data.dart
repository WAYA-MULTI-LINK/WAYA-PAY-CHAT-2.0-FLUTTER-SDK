// To parse this JSON data, do
//
//     final authorizationData = authorizationDataFromJson(jsonString);

import 'dart:convert';

AuthorizationData authorizationDataFromJson(String str) => AuthorizationData.fromJson(json.decode(str));

String authorizationDataToJson(AuthorizationData data) => json.encode(data.toJson());

class AuthorizationData {
    DateTime? timeStamp;
    bool? status;
    String? message;
    Data? data;

    AuthorizationData({
        this.timeStamp,
        this.status,
        this.message,
        this.data,
    });

    AuthorizationData copyWith({
        DateTime? timeStamp,
        bool? status,
        String? message,
        Data? data,
    }) => 
        AuthorizationData(
            timeStamp: timeStamp ?? this.timeStamp,
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory AuthorizationData.fromJson(Map<dynamic, dynamic> json) => AuthorizationData(
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
}

class Data {
    String? transactionId;
    String? status;
    String? is3DsEnabled;
    String? processor;
    String? message;
    String? paymentId;
    String? amount;
    String? responseCode;
    String? plainTextSupportMessage;
    String? merchantRedirectUrl;

    Data({
        this.transactionId,
        this.status,
        this.is3DsEnabled,
        this.processor,
        this.message,
        this.paymentId,
        this.amount,
        this.responseCode,
        this.plainTextSupportMessage,
        this.merchantRedirectUrl,
    });

    Data copyWith({
        String? transactionId,
        String? status,
        String? is3DsEnabled,
        String? processor,
        String? message,
        String? paymentId,
        String? amount,
        String? responseCode,
        String? plainTextSupportMessage,
        String? merchantRedirectUrl,
    }) => 
        Data(
            transactionId: transactionId ?? this.transactionId,
            status: status ?? this.status,
            is3DsEnabled: is3DsEnabled ?? this.is3DsEnabled,
            processor: processor ?? this.processor,
            message: message ?? this.message,
            paymentId: paymentId ?? this.paymentId,
            amount: amount ?? this.amount,
            responseCode: responseCode ?? this.responseCode,
            plainTextSupportMessage: plainTextSupportMessage ?? this.plainTextSupportMessage,
            merchantRedirectUrl: merchantRedirectUrl ?? this.merchantRedirectUrl,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json["transactionId"],
        status: json["status"],
        is3DsEnabled: json["is3dsEnabled"],
        processor: json["processor"],
        message: json["message"],
        paymentId: json["paymentId"],
        amount: json["amount"],
        responseCode: json["responseCode"],
        plainTextSupportMessage: json["plainTextSupportMessage"],
        merchantRedirectUrl: json["merchantRedirectUrl"],
    );

    Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "status": status,
        "is3dsEnabled": is3DsEnabled,
        "processor": processor,
        "message": message,
        "paymentId": paymentId,
        "amount": amount,
        "responseCode": responseCode,
        "plainTextSupportMessage": plainTextSupportMessage,
        "merchantRedirectUrl": merchantRedirectUrl,
    };
}
