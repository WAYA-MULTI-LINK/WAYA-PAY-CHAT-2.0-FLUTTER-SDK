
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/models/customer.dart';
import 'package:wayapay/src/models/traansaction_status.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/main_page/payment_page.dart';
import 'package:wayapay/src/service/transaction_service.dart';
import 'package:wayapay/src/utils/constants.dart';

import 'wayapay_platform_interface.dart';
export 'package:wayapay/src/models/charge.dart';
export 'package:wayapay/src/widget/appbar.dart';
export 'package:wayapay/src/models/traansaction_status.dart';

class Wayapay {
  Future<String?> getPlatformVersion() {
    return WayapayPlatform.instance.getPlatformVersion();
  }

  Future<TransactionStatus?> checkout(BuildContext cont, Charge charge,
      {String? transRef, CustomerCharge? customerData}) async {
        
    var data = await Navigator.push(
      cont,
      MaterialPageRoute(
        builder: (context) => App(
          transRef: transRef,
          charge: charge,
          mainContext: context,
          data: customerData,
        ),
        settings: const RouteSettings(
          name: 'wayapay',
        ),
      ),
    );
    return data;
  }
}

class App extends StatelessWidget {
  final Charge charge;
  final String? transRef;
  final CustomerCharge? data;
  final BuildContext mainContext;
  const App(
      {Key? key,
      required this.charge,
      required this.mainContext,
      this.transRef, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('qqqq is $data');
    return ChangeNotifierProvider(
      create: (_) => TransactionProvider(
          charge,
          TransactionService(
              charge.isTest ? Strings.stagingBaseUrl : Strings.baseUrl),
          mainContext,transRef,data),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //routeInformationParser: const MyRouteInformationParser(),
        home: PaymentPage(
          transRef: transRef,
          charge: charge,
        ),
      ),
    );
  }
}
