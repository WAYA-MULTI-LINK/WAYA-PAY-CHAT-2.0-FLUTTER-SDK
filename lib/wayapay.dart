

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/common/my_strings.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/models/traansaction_status.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/main_page/payment_page.dart';
import 'package:wayapay/src/service/transaction_service.dart';
import 'package:wayapay/src/utils/constants.dart';


import 'wayapay_platform_interface.dart';
export 'package:wayapay/src/models/charge.dart';
export 'package:wayapay/src/widget/appbar.dart';

class Wayapay {

  Future<String?> getPlatformVersion() {
    return WayapayPlatform.instance.getPlatformVersion();
  }


 Future<TransactionStatus?> checkout(BuildContext cont,Charge charge)async{


   var data = await Navigator.push(
      cont,
     MaterialPageRoute(
          builder: (context) => App(
            charge:charge ,
            mainContext: context,
          ),
          settings: const RouteSettings(name: 'wayapay',)),
    );
   return data;

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


