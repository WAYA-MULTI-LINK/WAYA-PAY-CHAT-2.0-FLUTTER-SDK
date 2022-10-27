import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:wayapay/src/common/my_strings.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/models/failure.dart';
import 'package:wayapay/src/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:wayapay/src/models/traansaction_status.dart';
import 'package:wayapay/src/models/ussd_payload.dart';
import 'package:wayapay/src/utils/constants.dart';
class TransactionService{

final String baseUrl;

  var client = http.Client();

  TransactionService(this.baseUrl);
 Duration timeLimit = const Duration(seconds: 20);
  Future<Map?> startTransaction(Charge charge) async {
    try {
      var map = jsonEncode(charge.toJson());
      var response = await client.post(Uri.parse(baseUrl+Strings.transactionRequestUrl),
          body: map,
          headers: {
        "Content-type": "application/json",
      }).timeout(timeLimit);
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
      var response = await client.post(Uri.parse(baseUrl+Strings.cardEncriptionUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
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
      var map = jsonEncode(payInfo);
      var response = await client.post(Uri.parse(baseUrl+Strings.transactionPaymentUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
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
      var response = await client.post(Uri.parse(baseUrl+Strings.transactionProcessingUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
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
      var response = await client.get(Uri.parse(baseUrl+Strings.getUssdBanksUrl),
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
      var response = await client.post(Uri.parse(baseUrl+Strings.ussdTransactionUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
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


  Future<TransactionStatus?> getUssdStatus(String  tranID) async {
    try {
      var response = await client.get(Uri.parse("${baseUrl+Strings.ussdTransactionStatusUrl}/$tranID"),
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      if(response.statusCode==200){
        return TransactionStatus(
            success: true,
            id: "",
            message: data['data']??""
        );
      }else{
        return TransactionStatus(
            success: false,
            id:"" ,
            message: data['details'].toString()??"something went wrong"
        );
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





  Future<dynamic> payAttitude(String cardEncrypt,String tranId) async {
    try {
      var map = jsonEncode({
        "cardEncrypt":cardEncrypt,
        "tranId":tranId
      });
      var response = await client.post(Uri.parse(baseUrl+Strings.postPayAttitudeUrl),
          body: map,
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
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


  Future<TransactionStatus?> transactionStatus(String  tranID) async {
    //print("${baseUrl+Strings.transactionStatusUrl}/$tranID");
    try {
      var response = await client.get(Uri.parse("${baseUrl+Strings.transactionStatusUrl}/$tranID"),
          headers: {
            "Content-type": "application/json",
          }).timeout(timeLimit);
      var data = jsonDecode(response.body);
      if(response.statusCode==200){
        return TransactionStatus(
            success: data['data']['Status']=="SUCCESSFUL"?true:false,
            id: "",
            message: "Transaction ${data['data']['Status']??""}".toUpperCase()
        );
      }else{
        return TransactionStatus(
            success: false,
            id:"" ,
            message: data['details'].toString()
        );
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


Future<Map?> loginToWallet(String email,String password) async {
  try {
    var map = jsonEncode({
      "emailOrPhoneNumber": email,
      "password": password
    });
    var response = await client.post(Uri.parse(baseUrl+Strings.loginToWallet),
        body: map,
        headers: {
          "Content-type": "application/json",
        }).timeout(timeLimit);
    var data = jsonDecode(response.body);
    if(response.statusCode==201){
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



Future<TransactionStatus> makePaymentToWallet(String acctNumber,String pin,String tranRef,String device,String token) async {
  try {
    var map = jsonEncode({
      "accountNo": acctNumber,
      "pin": pin,
      "refNo": tranRef,
      "deviceInformation":device
    });
    var response = await client.post(Uri.parse(baseUrl+Strings.makePaymentToWallet),
        body: map,
        headers: {
          "Content-type": "application/json",
          "authorization": token,
        });
    var data = jsonDecode(response.body);
     return TransactionStatus(
         success: data['status'],
         message: data['message'],
         id: "");
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
    var map = jsonEncode(
        {
          "qrExpiryDate": DateTime.now().add(const Duration(seconds:120 )).toIso8601String(),
          "refNo": tranId
        }
    );
    var response = await client.post(Uri.parse(baseUrl+Strings.getQrcode),
        body: map,
        headers: {
          "Content-type": "application/json",
        }).timeout(timeLimit);
    var data = jsonDecode(response.body);
    if(response.statusCode==201){
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


}

//veragreen20@gmail.com
//Password@234