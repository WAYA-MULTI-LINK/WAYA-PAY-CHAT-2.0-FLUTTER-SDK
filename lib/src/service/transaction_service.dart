import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/models/failure.dart';
import 'package:wayapay/src/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:wayapay/src/models/ussd_payload.dart';
import 'package:wayapay/src/utils/constants.dart';
class TransactionService{



  var client = http.Client();

  Future<Map?> startTransaction(Charge charge) async {
    try {
      var map = jsonEncode(charge.toJson());
      var response = await client.post(Uri.parse(Strings.transactionRequestUrl),
          body: map,
          headers: {
        "Content-type": "application/json",
      });
      var data = jsonDecode(response.body);
     if(response.statusCode==200){
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
      var map = jsonEncode(
          {
            "encryptString": text,
            "merchantPublicKey": sdkKey
          }
      );
      var response = await client.post(Uri.parse(Strings.cardEncriptionUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          });
      var data = jsonDecode(response.body);
      if(response.statusCode==200){
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
      print(payInfo);
      var map = jsonEncode(payInfo);
      var response = await client.post(Uri.parse(Strings.transactionPaymentUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          });
      var data = jsonDecode(response.body);
      if(response.statusCode==200){

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


  Future<Map?> processCardPayment(String cardData,String tranId) async {
    try {
      var map = jsonEncode({
        "cardEncrypt":cardData,
        "tranId":tranId
      });
      var response = await client.post(Uri.parse(Strings.transactionProcessingUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          });
      var data = jsonDecode(response.body);
      if(response.statusCode==200){

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


  Future<Map?> getBankList() async {
    try {
      var response = await client.get(Uri.parse(Strings.getUssdBanksUrl),
          headers: {
            "Content-type": "application/json",
          });
      var data = jsonDecode(response.body);
      if(response.statusCode==200){

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
      var response = await client.post(Uri.parse(Strings.ussdTransactionUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          });
      var data = jsonDecode(response.body);
      if(response.statusCode==200){
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


  Future<Map?> getUssdStatus(String  tranID) async {
    try {
      var response = await client.get(Uri.parse("${Strings.ussdTransactionStatusUrl}/$tranID"),
          headers: {
            "Content-type": "application/json",
          });
      var data = jsonDecode(response.body);
      if(response.statusCode==200){

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


  Future<dynamic> payAttitude(String cardEncrypt,String tranId) async {
    try {
      var map = jsonEncode({
        "cardEncrypt":cardEncrypt,
        "tranId":tranId
      });
      print(map);
      var response = await client.post(Uri.parse(Strings.postPayAttitudeUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          });
      var data = jsonDecode(response.body);
      print(data);
      print(response.statusCode);
      if(response.statusCode==200){

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


}