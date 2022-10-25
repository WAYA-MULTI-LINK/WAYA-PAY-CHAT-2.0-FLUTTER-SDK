

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/common/my_strings.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/main_page/payment_page.dart';
import 'package:wayapay/src/service/transaction_service.dart';
import 'package:wayapay/src/utils/constants.dart';
import 'package:wayapay/src/utils/information.dart';

import 'wayapay_platform_interface.dart';

class Wayapay {

  Future<String?> getPlatformVersion() {
    return WayapayPlatform.instance.getPlatformVersion();
  }


   checkout(BuildContext cont)async{
    var charge = Charge(
        amount: 2,
        isTest: false,
        description:"mobile payment",
        deviceInformation:jsonEncode({'phone':"iphone"}),
        customer: Customer(name: "chisom Eti", email: "chisom@gmail.com", phoneNumber: "08103565207"),
        merchantId: 'MER_3zUWo1656418606145pYewf',
        wayaPublicKey: "WAYAPUBK_PROD_0x271b51f9ec964a59a4438ddf2f71cea0"
    );

   var data = await Navigator.push(
      cont,
     MaterialPageRoute(
          builder: (context) => App(
            charge:charge ,
            mainContext: context,
          ),
          settings: const RouteSettings(name: 'wayapay',)),
    );
   print(data);
  }


}

class App extends StatelessWidget {
  final Charge charge;
  final BuildContext mainContext;
  const App({Key? key,required this.charge, required this.mainContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>TransactionProvider(
          charge,
          TransactionService(
              charge.isTest?Strings.stagingBaseUrl:Strings.baseUrl
          ),
        mainContext
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //routeInformationParser: const MyRouteInformationParser(),
        home: PaymentPage(
          charge:charge ,
        ),
      ),
    );
  }
}


