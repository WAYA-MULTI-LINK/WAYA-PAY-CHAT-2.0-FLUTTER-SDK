import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wayapay/src/alert/alert.dart';
import 'package:wayapay/src/models/bottom_nav_model.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/res/color.dart';
import 'package:wayapay/src/res/text.dart';
import 'package:wayapay/src/screen/checkout/account/account.dart';
import 'package:wayapay/src/screen/checkout/pay_attitude/pay_attitude.dart';
import 'package:wayapay/src/screen/checkout/ussd/ussd.dart';
import 'package:wayapay/src/screen/main_page/footer.dart';
import 'package:wayapay/src/screen/main_page/top.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/bottom_nav.dart';

import '../checkout/card/card.dart';

class PaymentPage extends StatefulWidget {
  final Charge charge;
  final String? transRef;
  const PaymentPage({Key? key, required this.charge, this.transRef})
      : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var method = [
    BottomNavModel(
        name: "Card", icon: Icons.credit_card, body: const CardMethod()),
    BottomNavModel(
        name: "USSD",
        icon: Icons.perm_phone_msg_rounded,
        body: const UssdCheckout()),
    BottomNavModel(
        name: "Account",
        icon: Icons.account_balance_wallet,
        body: const AccountPayment()),
    BottomNavModel(
        name: "Pay Attitude",
        icon: Icons.phone_enabled_rounded,
        body: const PayAttitude())
  ];

  var method2 = [
    BottomNavModel(
        name: "Account",
        icon: Icons.account_balance_wallet,
        body: const AccountPayment()),
         BottomNavModel(
        name: "Card", icon: Icons.credit_card, body: const CardMethod()),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var model = context.watch<TransactionProvider>();
    return WillPopScope(
      onWillPop: () async {
        // Alerts.onPaymentCancel(Get.context!);
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: (){
            //      var model = context.read<TransactionProvider>();
            //     // model.startTransaction();
            //    //  Navigator.pop(model.mainContext);
            //     // Navigator.popUntil(model.mainContext, (route) {
            //     //   print(route.settings.name);
            //     //   return route.settings.name == 'wayapay';
            //     // },
            //     //
            //     // );
            //   },
            // ),
            appBar: appBar(context),
            body: widget.transRef == null
                ? model.customerCharge == null
                    ? Center(
                        child: SizedBox(
                          height: 104,
                          width: 104,
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                            backgroundColor: Colors.grey[100],
                            valueColor: const AlwaysStoppedAnimation(
                                AppColor.mainColor),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            const CheckoutTop(),
                            method[currentIndex].body,
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Select preferred payment method",
                              style: AppTextTheme.large,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomBottomNav(
                                items: method,
                                onTap: (e) {
                                  setState(() {
                                    currentIndex = e;
                                  });
                                },
                                currentIndex: currentIndex),
                            const SizedBox(
                              height: 30,
                            ),
                            const CheckoutFooter(),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const CheckoutTop(),
                        method2[currentIndex].body,
                        const SizedBox(
                          height: 30,
                        ),
                        // Text(
                        //   "Select preferred payment method",
                        //   style: AppTextTheme.large,
                        // ),
                        const SizedBox(
                          height: 80,
                        ),
                        CustomBottomNav(
                            items: method2,
                            onTap: (e) {
                              setState(() {
                                currentIndex = e;
                              });
                            },
                            currentIndex: currentIndex),
                        const SizedBox(
                          height: 30,
                        ),
                        const CheckoutFooter(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (widget.transRef == null) {
        print(widget.transRef);
        startTransaction();
      }
    });
  }

  void startTransaction() {
    var model = context.read<TransactionProvider>();
    model.startTransaction().then((value) {
      print(value);
      if (value != null) {
      } else {
        var model = context.read<TransactionProvider>();
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "Invalid profile/ api key",
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(model.mainContext);
        });
      }
    });
    model.getBanks();
  }

  check(TransactionProvider model, BuildContext context) async {
    Alerts.onProcessingAlert(context, onLoading: (cxt) {
      model.getUssdStatus().then((value) {
        Navigator.pop(cxt);
        Future.delayed(const Duration(milliseconds: 500), () {
          // Alerts.onSuccessAlert(context);
          if (value != null) {
            if (value.success) {
              Alerts.onSuccessAlert(context);
            } else {
              Alerts.onPaymentFailed(context, message: value.message);
            }
          }
        });
      }).catchError((e) {
        Navigator.pop(cxt);
      });
    });
  }
}
