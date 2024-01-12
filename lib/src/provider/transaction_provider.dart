import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wayapay/src/enum/app_state.dart';
import 'package:wayapay/src/models/authorization_data.dart';
import 'package:wayapay/src/models/bank_model.dart';
import 'package:wayapay/src/models/card.dart';
import 'package:wayapay/src/models/card_process_data.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/models/customer.dart';
import 'package:wayapay/src/models/encrpt.dart';
import 'package:wayapay/src/models/htm_data.dart';
import 'package:wayapay/src/models/paymentData.dart';
import 'package:wayapay/src/models/qr_code_data.dart';
import 'package:wayapay/src/models/traansaction_status.dart';
import 'package:wayapay/src/models/user_data.dart';
import 'package:wayapay/src/models/ussd_model.dart';
import 'package:wayapay/src/models/ussd_payload.dart';
import 'package:wayapay/src/provider/base_veiw_model.dart';
import 'package:wayapay/src/service/transaction_service.dart';

var deviceInfo =
    "{\"vendorSub\":\"\",\"productSub\":\"20030107\",\"vendor\":\"Google Inc.\",\"maxTouchPoints\":0,\"scheduling\":{},\"userActivation\":{},\"doNotTrack\":null,\"geolocation\":{},\"connection\":{},\"plugins\":{\"0\":{\"0\":{},\"1\":{}},\"1\":{\"0\":{},\"1\":{}},\"2\":{\"0\":{},\"1\":{}},\"3\":{\"0\":{},\"1\":{}},\"4\":{\"0\":{},\"1\":{}}},\"mimeTypes\":{\"0\":{},\"1\":{}},\"pdfViewerEnabled\":true,\"webkitTemporaryStorage\":{},\"webkitPersistentStorage\":{},\"hardwareConcurrency\":8,\"cookieEnabled\":true,\"appCodeName\":\"Mozilla\",\"appName\":\"Netscape\",\"appVersion\":\"5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36\",\"platform\":\"MacIntel\",\"product\":\"Gecko\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36\",\"language\":\"en-GB\",\"languages\":[\"en-GB\",\"en-US\",\"en\",\"ca\"],\"onLine\":true,\"webdriver\":false,\"bluetooth\":{},\"clipboard\":{},\"credentials\":{},\"keyboard\":{},\"managed\":{},\"mediaDevices\":{},\"storage\":{},\"serviceWorker\":{},\"virtualKeyboard\":{},\"wakeLock\":{},\"deviceMemory\":8,\"ink\":{},\"hid\":{},\"locks\":{},\"mediaCapabilities\":{},\"mediaSession\":{},\"permissions\":{},\"presentation\":{},\"serial\":{},\"usb\":{},\"windowControlsOverlay\":{},\"xr\":{},\"userAgentData\":{\"brands\":[{\"brand\":\"Chromium\",\"version\":\"106\"},{\"brand\":\"Google Chrome\",\"version\":\"106\"},{\"brand\":\"Not;A=Brand\",\"version\":\"99\"}],\"mobile\":false,\"platform\":\"macOS\"}}";

class TransactionProvider extends BaseViewModel {
  final Charge charge;
  final String? transId;
  // final CustomerCharge? data;

  late String accountType;
  // late String transId;

  final TransactionService transactionService;
  final BuildContext mainContext;
  TransactionProvider(this.charge, this.transactionService, this.mainContext,
      this.transId, this.customerCharge);

  CustomerCharge? customerCharge;
  List<Bank> banks = [];

  Future<CustomerCharge?> startTransaction() async {
    try {
      setState(AppState.busy);
      var data = await transactionService.startTransaction(charge);
      setState(AppState.idle);
      if (data != null) {
        customerCharge = CustomerCharge.fromJson(data);
        print(customerCharge);
        notifyListeners();
        return customerCharge;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<String?> encryptCard(String cardNo) async {
    try {
      setState(AppState.busy);
      var data =
          await transactionService.encryptCard(cardNo, charge.wayaPublicKey);
      setState(AppState.idle);
      return data;
    } catch (e) {
      setState(AppState.idle);

      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<PaymentData?> processCardPayment(
      PaymentCard paymentCard, String encryptData, String pin) async {
    try {
      setState(AppState.busy);
      var cardData = CardProcessData(
        cardholder: charge.customer.name,
        encryptCardNo: paymentCard.number!,
        expiry: "${paymentCard.expiryYear}${add(paymentCard.expiryMonth!)}${paymentCard.expiryMonth}",
        // "${add(paymentCard.expiryMonth!)}${paymentCard.expiryMonth}/${paymentCard.expiryYear}",
        mobile: charge.customer.phoneNumber,
        pin: pin,
        securityCode: paymentCard.cvc!,
        recurrent: false,
        merchantId: charge.merchantId,
        deviceInformation: deviceInfo,
        tranId: customerCharge!.data.tranId,
        scheme: paymentCard.type ?? "",
        wayaPublicKey: charge.wayaPublicKey,
      ).toJson();

      print('card data is $cardData');
      var data = await transactionService.cardPayment(cardData);
      setState(AppState.idle);
      if (data != null) {
        var encrypt = PaymentData.fromJson(data);
        return encrypt;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

   Future<AuthorizationData?> authorizeCard(String pin, String tranId) async {
    try {
      setState(AppState.busy);
      var data = await transactionService.authorizeCard(pin, tranId);
      setState(AppState.idle);
      if (data != null) {
        // var html = HtmlData.fromJson(data);
        var html = AuthorizationData.fromJson(data);
        return html;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<Encrypt?> payAttitudePayment(String phone) async {
    try {
      setState(AppState.busy);
      var cardData;
      //  = CardProcessData(
      //         cardholder: "",
      //         encryptCardNo: "",
      //         expiry: "",
      //         mobile: phone,
      //         pin: "",
      //         deviceInformation: deviceInfo,
      //         tranId: customerCharge!.data.tranId,
      //         scheme: "payattitude",
      //         wayaPublicKey: charge.wayaPublicKey)
      //     .toJson();
      var data = await transactionService.cardPayment(cardData);
      setState(AppState.idle);
      if (data != null) {
        var encrypt = Encrypt.fromJson(data);
        return encrypt;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<dynamic> postPayAttitude(String cardEncrypt) async {
    try {
      //setState(AppState.busy);
      var data = await transactionService.payAttitude(
          cardEncrypt, customerCharge!.data.tranId);
      setState(AppState.idle);
      if (data != null) {
        return data;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<HtmlData?> processCard(String cardData, String tranId) async {
    try {
      setState(AppState.busy);
      var data = await transactionService.processCardPayment(cardData, tranId);
      setState(AppState.idle);
      if (data != null) {
        var html = HtmlData.fromJson(data);
        // var html = PaymentData.fromJson(data);
        return html;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

    Future<AuthorizationData?> processPayment(String cardData, String tranId, String pin) async {
    try {
      setState(AppState.busy);
      var data = await transactionService.processPayment(cardData, tranId, pin);
      setState(AppState.idle);
      if (data != null) {
        var html = AuthorizationData?.fromJson(data);
        // var html = PaymentData.fromJson(data);
        return html;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<BankModel?> getBanks() async {
    try {
      setState(AppState.busy);
      var data = await transactionService.getBankList();
      setState(AppState.idle);
      if (data != null) {
        var bankModel = BankModel.fromJson(data);
        banks = bankModel.data;
        notifyListeners();
        return bankModel;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<Ussd?> getUssd(Bank bankData, {String channel = "USSD"}) async {
    try {
      setState(AppState.busy);
      var payload = UssdPayload(
          amount: charge.amount.toInt(),
          bankId: bankData.bankId,
          channel: channel,
          customerEmail: charge.customer.email,
          customerId: customerCharge!.data.customerId,
          merchantId: charge.merchantId,
          paymentDescription: "Wayapay Demo account",
          subMerchantName: "Green",
          transactionReference:
              int.parse(customerCharge!.data.tranId.substring(6, 16)),
          transactionType: 0,
          transactionRefNo: customerCharge!.data.tranId);
      var data = await transactionService.getUssd(payload);
      setState(AppState.idle);
      if (data != null) {
        var ussd = Ussd.fromJson(data);
        notifyListeners();
        return ussd;
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  String add(int expiryMonth) {
    if (expiryMonth.toString().length == 1) {
      return "0";
    } else {
      return "";
    }
  }

  Future<TransactionStatus?> getUssdStatus() async {
    try {
      setState(AppState.busy);
      var data =
          await transactionService.getUssdStatus(customerCharge!.data.tranId);
      setState(AppState.idle);
      return data;
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<TransactionStatus?> checkStatus() async {
    try {
      setState(AppState.busy);
      var data = await transactionService
          .transactionStatus(customerCharge!.data.tranId);
      setState(AppState.idle);
      return data;
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<UserData?> loginToWallet(String email, String password) async {
    try {
      setState(AppState.busy);
      var data = await transactionService.loginToWallet(email, password,
          accountType: accountType);
      setState(AppState.idle);
      if (data != null) {
        return UserData.fromJson(data);
      }
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<TransactionStatus?> payToWallet(
      String acctNumber, String pin, String token) async {
    try {
      setState(AppState.busy);
      var data = await transactionService.makePaymentToWallet(acctNumber, pin,
          transId ?? customerCharge!.data.tranId, deviceInfo, token,
          accountType: accountType);
      setState(AppState.idle);
      return data;
    } catch (e) {
      setState(AppState.idle);
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<QrCodeData?> getQrCode() async {
    try {
      setState(AppState.busy);
      var data =
          await transactionService.getQrCode(customerCharge!.data.tranId);
      setState(AppState.idle);
      if (data != null) {
        return QrCodeData.fromJson(data);
      }
    } catch (e) {
      setState(AppState.idle);

      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }
}
