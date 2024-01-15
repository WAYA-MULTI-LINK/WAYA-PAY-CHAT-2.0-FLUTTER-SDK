// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/alert/alert.dart';
import 'package:wayapay/src/common/constants.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/main_page/footer.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/pin_feild.dart';

class OTP extends StatelessWidget {
  const OTP({
    Key? key,
    required this.cardNo,
    required this.tranId,
  }) : super(key: key);

  final String cardNo;
  final String tranId;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: appBar(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(),
                const SizedBox(
                  height: 40,
                ),
                // const CheckoutTop(),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Kindly provide your 6-digit OTP \npin to authorize this payment",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: (size.width * size.height) * 0.00005,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(
                  height: 27,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  focusedBorderColor: Constants.wayapay_color,
                  borderColor: Constants.wayapay_color,
                  showFieldAsBox: true,
                  fieldWidth: size.width * 0.10,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(fontSize: 24),
                  margin: const EdgeInsets.only(right: 16.0),
                  fieldHeight: 75.6,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) async {
                    if (verificationCode.length == 6) {
                      var model = context.read<TransactionProvider>();
                      // final result = await model.processPayment(
                      //     cardNo, tranId, verificationCode);
                      // if (result != null) {
                      //   check(model, context,verificationCode);
                      // }
                       check(model, context,verificationCode);

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AuthenticateCard(
                      //               paymentCard: paymentCard,
                      //               pin: verificationCode,
                      //             )));
                    }
                  }, // end
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Didn't get the OTP? Dial *723*0# on your phone (MTN,Etisalat,Airtel) Glo,use *805*0#.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: (size.width * size.height) * 0.00005,
                          fontWeight: FontWeight.w400)),
                ),
                SizedBox(
                  height: size.height * 0.4,
                ),
                const CheckoutFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  check(TransactionProvider model, BuildContext context,
      String verificationCode) async {
    Alerts.onProcessingAlert(context, onLoading: (cxt) async {
      final result =
          await model.processPayment(cardNo, tranId, verificationCode);
      if (result != null) {
        model.checkStatus().then((value) {
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
      }else{
         Navigator.pop(cxt);
        //  Alerts.onPaymentFailed(context, message: result!.message);
        

      }
    });
  }
}
