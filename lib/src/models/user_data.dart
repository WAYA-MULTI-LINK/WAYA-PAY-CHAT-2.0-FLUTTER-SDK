// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.timeStamp,
    required this.status,
    required this.message,
    required this.data,
  });

  String timeStamp;
  bool status;
  String message;
  Data data;

  factory UserData.fromJson(Map<dynamic, dynamic> json) => UserData(
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
    required  this.wallet,
    required   this.token,
    required  this.merchantName,
  });

  List<WalletData> wallet;
  String token;
  String merchantName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wallet: List<WalletData>.from(json["wallet"].map((x) => WalletData.fromJson(x))),
    token: json["token"],
    merchantName: json["merchantName"],
  );

  Map<String, dynamic> toJson() => {
    "wallet": List<dynamic>.from(wallet.map((x) => x.toJson())),
    "token": token,
    "merchantName": merchantName,
  };
}

class WalletData {
  WalletData({
    required  this.accountNo,
    required  this.acctName,
    required  this.clrBalAmt,
    required  this.walletDefault,
     this.acctCrncyCode,
  });

  String accountNo;
  String acctName;
  double clrBalAmt;
  bool walletDefault;
  String? acctCrncyCode;

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
    accountNo: json["accountNo"],
    acctName: json["acct_name"],
    clrBalAmt: json["clr_bal_amt"].toDouble(),
    walletDefault: json["walletDefault"],
    acctCrncyCode: json["acct_crncy_code"],
  );

  Map<String, dynamic> toJson() => {
    "accountNo": accountNo,
    "acct_name": acctName,
    "clr_bal_amt": clrBalAmt,
    "walletDefault": walletDefault,
    "acct_crncy_code": acctCrncyCode,
  };
}
