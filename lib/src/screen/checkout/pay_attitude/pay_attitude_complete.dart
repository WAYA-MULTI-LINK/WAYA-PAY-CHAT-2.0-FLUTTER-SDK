import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/alert/alert.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/res/color.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/button.dart';

class PayAttitudeComplete extends StatelessWidget {
  const PayAttitudeComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = context.watch<TransactionProvider>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 50,right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(),
            SizedBox(
              height: 104,
              width: 104,
              child: CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor: Colors.grey[100],
                valueColor: const AlwaysStoppedAnimation(AppColor.mainColor),
              ),
            ),
            const  SizedBox(height: 23,),
            Text(
              "Kindly click on this button if you’ve completed this transaction on your mobile.",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: (width * height) * 0.00005,
                ),
              ),
              textAlign: TextAlign.center,
            ),
           const  SizedBox(height: 23,),
            AccentButton(
              key: const Key("PayButton"),
              appState: model.appState,
              onPressed: (){
                check(model, context);
              },
              text: "I have completed this payment",
              //showProgress: _validated
            ),
          ],
        ),
      ),
    );
  }

  check(TransactionProvider model, BuildContext context) async{
    Alerts.onProcessingAlert(context,onLoading: (cxt){
      model.checkStatus().then((value){
        Navigator.pop(cxt);
        Future.delayed(const Duration(milliseconds: 500),(){
          // Alerts.onSuccessAlert(context);
          if(value!=null){
            if(value.success){
              Alerts.onSuccessAlert(context);
            }else{
              Alerts.onPaymentFailed(context,message: value.message);
            }
          }
        });

      }).catchError((e){
        Navigator.pop(cxt);
      });
    });

  }

}
