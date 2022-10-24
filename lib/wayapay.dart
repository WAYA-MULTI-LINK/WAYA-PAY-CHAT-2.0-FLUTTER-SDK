

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/main_page/payment_page.dart';

import 'wayapay_platform_interface.dart';

class Wayapay {

  Future<String?> getPlatformVersion() {
    return WayapayPlatform.instance.getPlatformVersion();
  }


   checkout(BuildContext cont){
    var charge = Charge(amount: 2,
        description:"mobile payment",
        deviceInformation:jsonEncode({'phone':"iphone"}),
        customer: Customer(name: "chisom Eti", email: "chisom@gmail.com", phoneNumber: "08103565207"),
        merchantId: 'MER_3zUWo1656418606145pYewf',
        wayaPublicKey: "WAYAPUBK_PROD_0x271b51f9ec964a59a4438ddf2f71cea0"
    );
   return Navigator.push(
      cont,
      MaterialPageRoute(
          builder: (context) => App(
            charge:charge ,
          ),
          settings: const RouteSettings(name: 'wayapay',)),
    );
  }


}

class App extends StatelessWidget {
  final Charge charge;
  const App({Key? key,required this.charge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>TransactionProvider(charge)),
      ],
      child: MaterialApp(
        home:PaymentPage(
          charge:charge ,
        ) ,
      ),
    );
  }
}


