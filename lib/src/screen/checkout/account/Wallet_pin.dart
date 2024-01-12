import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/alert/alert.dart';
import 'package:wayapay/src/common/constants.dart';
import 'package:wayapay/src/models/user_data.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/main_page/footer.dart';
import 'package:wayapay/src/screen/main_page/top.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/pin_feild.dart';

class WalletPin extends StatelessWidget {
  final WalletData walletData;
  final String token;
  const WalletPin({Key? key, required this.walletData, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var model = context.watch<TransactionProvider>();
    return  GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(),
                const SizedBox(height: 40,),
                const CheckoutTop(),
                const SizedBox(height: 40,),
                Text(
                  "Transaction Pin",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: (size.width * size.height) * 0.00005,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 10,),
                Text(
                  "Please input your 4 digit pin to\n complete transaction",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
                const SizedBox(height: 27,),
                OtpTextField(
                  numberOfFields: 4,
                  focusedBorderColor: Constants.wayapay_color,
                  borderColor: Constants.wayapay_color,
                  showFieldAsBox: true,
                  fieldWidth: size.width*0.15,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(fontSize: 24),
                  margin: const EdgeInsets.only(right: 16.0),
                  fieldHeight: 75.6,
                  onCodeChanged: (String code) {

                  },
                  onSubmit: (String pin) {
                    if(pin.length==4){
                      pay(context,model,pin);
                    }
                  }, // end
                ),
                SizedBox(height: size.height*0.4,),
                const CheckoutFooter(),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pay(BuildContext context, TransactionProvider model,String pin) {
    Alerts.onProcessingAlert(context,onLoading: (cxt){
      model.payToWallet(walletData.accountNo, pin,token).then((value){
        Navigator.pop(cxt);
        Future.delayed(const Duration(milliseconds: 500),(){
          // Alerts.onSuccessAlert(context);
          if(value!=null){
            if(value.success){
              Alerts.onSuccessAlert(context);
            }else{
              Alerts.onPaymentFailed(context,message: value.message);
            }
            // Navigator.pop(cxt);
          }
        });

      }).catchError((e){
        Navigator.pop(cxt);
      });
    });
  }
}
