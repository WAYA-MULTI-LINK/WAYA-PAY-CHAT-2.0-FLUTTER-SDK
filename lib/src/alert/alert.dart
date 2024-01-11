
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/widget/cancel.dart';
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
     showDialog(
         context: context,
         builder: (context){
           return const SimpleDialog(
             children: [
               CanCelPayment()
             ],
           );
         }
     );
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
