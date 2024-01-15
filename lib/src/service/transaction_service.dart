import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/models/failure.dart';
import 'package:http/http.dart' as http;
import 'package:wayapay/src/models/traansaction_status.dart';
import 'package:wayapay/src/models/ussd_payload.dart';
import 'package:wayapay/src/utils/constants.dart';
import 'dart:developer' as developer;

class TransactionService {
  final String baseUrl;

  var client = http.Client();

  TransactionService(this.baseUrl);
  Duration timeLimit = const Duration(seconds: 20);

  
  Future<Map?> startTransaction(Charge charge) async {
    try {
      var map = jsonEncode(charge.toJson());
      var response = await client.post(
          Uri.parse(baseUrl + Strings.transactionRequestUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      // print(baseUrl + Strings.transactionRequestUrl);
      // print(charge.toJson());
      // print(response.body);
      interceptResponse(response);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data;
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

  Future<String?> encryptCard(String text, String sdkKey) async {
    try {
      var map =
          jsonEncode({"encryptString": text, "merchantPublicKey": sdkKey});
          
      var response = await client.post(
          Uri.parse(baseUrl + Strings.cardEncriptionUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      
     interceptResponse(response);
      if (response.statusCode == 200) {
        return data['data'];
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

  Future<Map?> cardPayment(Map payInfo) async {
    try {
      var map = jsonEncode(payInfo);
      var response = await client.post(
          Uri.parse(baseUrl + Strings.transactionPaymentUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      print("card data is $data");
      interceptResponse(response);
      if (response.statusCode == 200) {
        return data;
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

    Future<dynamic> authorizeCard(String pin, String tranId) async {
    try {
      var map = jsonEncode({"pin": pin, "transactionId": tranId});
      var response = await client.post(
          Uri.parse(baseUrl + Strings.authorizationUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      interceptResponse(response);
      if (response.statusCode == 200) {
        return data;
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

  Future<Map?> processCardPayment(String cardData, String tranId) async {
    try {
      var map = jsonEncode({"cardEncrypt": cardData, "tranId": tranId});
      var response = await client.post(
          Uri.parse(baseUrl + Strings.transactionProcessingUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      interceptResponse(response);
      if (response.statusCode == 200) {
        return data;
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

    Future<Map?> processPayment(String cardData, String tranId, String otp) async {
    try {
      var map = jsonEncode({"cardEncrypt": cardData, "tranId": tranId, "otp":otp});
      var response = await client.post(
          Uri.parse(baseUrl + Strings.transactionProcessingUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      interceptResponse(response);
      if (response.statusCode == 200) {
        return data;
      }else{
        throw data['message'];
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure(e.toString());
    }
    return null;
  }

  Future<Map?> getBankList() async {
    try {
      var response = await client
          .get(Uri.parse(baseUrl + Strings.getUssdBanksUrl), headers: {
        "Content-type": "application/json",
      });
      var data = jsonDecode(response.body);
      interceptResponse(response);
      if (response.statusCode == 200) {
        return data;
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

  Future<Map?> getUssd(UssdPayload ussdPayload) async {
    try {
      var map = jsonEncode(ussdPayload.toJson());
      var response = await client.post(
          Uri.parse(baseUrl + Strings.ussdTransactionUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
          interceptResponse(response);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data;
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

  Future<TransactionStatus?> getUssdStatus(String tranID) async {
    try {
      var response = await client.get(
          Uri.parse("${baseUrl + Strings.ussdTransactionStatusUrl}/$tranID"),
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      interceptResponse(response);
      if (response.statusCode == 200) {
        return TransactionStatus(
            success: true, transactionId: "", message: data['data'] ?? "");
      } else {
        return TransactionStatus(
            success: false,
            transactionId: "",
            message: data['details'].toString() ?? "something went wrong");
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
  }

  Future<dynamic> payAttitude(String cardEncrypt, String tranId) async {
    try {
      var map = jsonEncode({"cardEncrypt": cardEncrypt, "tranId": tranId});
      var response = await client.post(
          Uri.parse(baseUrl + Strings.postPayAttitudeUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
          interceptResponse(response);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return "good";
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

//
  Future<TransactionStatus?> transactionStatus(String tranID) async {
    try {
      var response = await client.get(
          Uri.parse("${baseUrl + Strings.transactionStatusUrl}/$tranID"),
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      interceptResponse(response);
      if (response.statusCode == 200) {
        return TransactionStatus(
            success: data['data']['Status'] == "SUCCESSFUL" ? true : false,
            transactionId: "",
            message:
                "Transaction ${data['data']['Status'] ?? ""}".toUpperCase());
      } else {
        return TransactionStatus(
            success: false,
            transactionId: "",
            message: data['details'].toString());
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

  Future<Map?> loginToWallet(String email, String password,
      {required String accountType}) async {
    try {
      var map = jsonEncode({"emailOrPhoneNumber": email, "password": password});
      Map<String, String> headers = {
        "Content-type": "application/json",
        'CLIENT-ID': 'WAYAQUICK',
        'CLIENT-TYPE': accountType,
      };
      var response = await client
          .post(Uri.parse(baseUrl + Strings.loginToWallet),
              body: map, headers: headers)
          .timeout(timeLimit);

      print(headers);
      interceptResponse(response);
      var data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return data;
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

  Future<TransactionStatus> makePaymentToWallet(String acctNumber, String pin,
      String tranRef, String device, String token,
      {required String accountType}) async {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "authorization": token,
        'CLIENT-ID': 'WAYAQUICK',
        'CLIENT-TYPE': accountType,
      };
      var map = jsonEncode({
        "accountNo": acctNumber,
        "pin": pin,
        "refNo": tranRef,
        "deviceInformation": device
      });
      var response = await client.post(
          Uri.parse(baseUrl + Strings.makePaymentToWallet),
          body: map,
          headers: headers);
      interceptResponse(response);
      var data = jsonDecode(response.body);

      return TransactionStatus(
          success: data['status'], message: data['message'], transactionId: "");
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
  }

  Future<Map?> getQrCode(String tranId) async {
    try {
      var map = jsonEncode({
        "qrExpiryDate":
            DateTime.now().add(const Duration(seconds: 120)).toIso8601String(),
        "refNo": tranId
      });
      var response = await client
          .post(Uri.parse(baseUrl + Strings.getQrcode), body: map, headers: {
        "Content-type": "application/json",
      }).timeout(timeLimit);
      interceptResponse(response);
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return data;
      }
    } on SocketException catch (_) {
      throw Failure("No internet connection");
    } on HttpException catch (_) {
      throw Failure("Service not currently available");
    } on TimeoutException catch (_) {
      throw Failure("Poor internet connection");
    } catch (e) {
      throw Failure("Something went wrong. Try again");
    }
    return null;
  }

  static interceptResponse(http.Response response) async {
    if (kDebugMode) {
      developer.log(response.request.toString());
      developer.log('''Response - ${response.statusCode}
          ${response.request!.url}''');
      developer.log(response.body.toString());
    }
  }


  
}

//veragreen20@gmail.com
//Password@234