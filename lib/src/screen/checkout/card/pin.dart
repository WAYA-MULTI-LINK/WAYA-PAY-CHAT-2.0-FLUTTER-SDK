import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayapay/src/common/constants.dart';
import 'package:wayapay/src/models/card.dart';
import 'package:wayapay/src/screen/checkout/card/authenticate.dart';
import 'package:wayapay/src/screen/main_page/footer.dart';
import 'package:wayapay/src/screen/main_page/top.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/pin_feild.dart';

class Pin extends StatelessWidget {
 final PaymentCard paymentCard;
  const Pin({Key? key, required this.paymentCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                  "Kindly provide your 4-digit card \npin to authorize this payment",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontSize: (size.width * size.height) * 0.00005,
                          fontWeight: FontWeight.w700)),
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
                  onSubmit: (String verificationCode) {
                    if(verificationCode.length==4){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>AuthenticateCard(
                            paymentCard: paymentCard,
                            pin: verificationCode,
                          )));
                    }
                  }, // end
                ),
                SizedBox(height: size.height*0.4,),
                 const CheckoutFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
