
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/models/customer.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/widget/button.dart';
import 'package:wayapay/src/widget/loading.dart';
import 'package:wayapay/src/widget/success.dart';


class Alerts {
  static  onProcessingAlert(context,
      {String message =
      "Please wait while we’re \n processing your payment",
        required Function(BuildContext context) onLoading
      }) {



    showDialog(
        context: context,
        builder:(context){
           return SimpleDialog(
             children: [
               Loading(onLoading: onLoading,
                   message: message,
                   context: context),
             ],
           );
        }
    );

  }



  static void onPaymentCancel(BuildContext context, ) {
    var charge = context.watch<TransactionProvider>().charge;
    var customerCharge = context.watch<TransactionProvider>().customerCharge;
    var alert = Alert(context: context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    alert = Alert(
      context: context,
      onWillPopActive: true,
      useRootNavigator: true,
      closeIcon: null,
      closeFunction: null,
      id: "PaymentCancel",
      content: SizedBox(
        width: width * 0.68,
        height: height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/cancel_icon.png',
              key: const Key("IssuerIcon"),
              height: height * 0.17,
              width: width * 0.17,
              package: 'wayapay_flutter',
            ),
            Text(
              "Payment in process.",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  )),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "Are you sure you want to \n cancel this payment?",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            AccentButton(
                key: const Key("cancelButton"),
                onPressed: () => {
                  alert.dismiss(),
                  Navigator.of(context).pop(),
                  Navigator.of(context).pushNamed("/")
                },
                text: "Yes, Cancel the payment",
                showProgress: false),
            SizedBox(
              height: height * 0.01,
            ),
            DialogButton(
                key: const Key("continueButton"),
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                onPressed: () => {

                },
                child: Text("No, I want to continue",
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: (width * height) * 0.00004,
                    ))),
          ],
        ),
      ),
      type: AlertType.none,
      buttons: [],
    );

    alert.show();
  }

  static void onSuccessAlert(BuildContext context) {
    var charge = context.read<TransactionProvider>().charge;
    var mainContext = context.read<TransactionProvider>().mainContext;
    var customerCharge = context.read<TransactionProvider>().customerCharge!;
   showDialog(context: context,
       builder: (context){
         return SimpleDialog(
           children: [
             SuccessTransaction(charge: charge, customerCharge: customerCharge,
               mainContext: mainContext,)
           ],
         );
       }
   );
  }

  static const String defaultError =
      "Error occured while processing your \npayment, kindly"
      " try again or choose a \ndifferent payment method.";

  static  onPaymentFailed(BuildContext context,
      {String? message = Alerts.defaultError}) {
    var charge = context.read<TransactionProvider>().charge;
    var customerCharge = context.read<TransactionProvider>().customerCharge;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
     showDialog(context: context,
         builder: (context){
          return SimpleDialog(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/error_icon.png',
                      key: const Key("IssuerIcon"),
                      height: height * 0.17,
                      width: width * 0.17,
                      package: 'wayapay',
                    ),
                    // Text(
                    //   "Payment Failed!",
                    //   textAlign: TextAlign.center,
                    //   style: GoogleFonts.dmSans(
                    //       textStyle: const TextStyle(
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 28,
                    //       )),
                    // ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18)),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    DialogButton(
                      width: 115,
                        key: const Key("startButton"),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("Ok",
                            style: GoogleFonts.lato(
                              color: Colors.grey,
                              fontSize: (width * height) * 0.00004,
                            ))),
                  ],
                ),
              ),
            ],
          );
         }
     );


  }
}
