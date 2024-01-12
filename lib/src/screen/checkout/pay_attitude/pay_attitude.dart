
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/checkout/card/input/base_textfield.dart';
import 'package:wayapay/src/screen/checkout/pay_attitude/pay_attitude_complete.dart';
import 'package:wayapay/src/widget/button.dart';

class PayAttitude extends StatefulWidget {
  const PayAttitude({Key? key}) : super(key: key);

  @override
  State<PayAttitude> createState() => _PayAttitudeState();
}

class _PayAttitudeState extends State<PayAttitude> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var model = context.watch<TransactionProvider>();
    return Padding(
      padding: const EdgeInsets.only(left:30,right: 30,top: 20,bottom: 20 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          // Image.asset(
          //   'assets/images/bulb_icon.png',
          //   key: const Key("bulbIcon"),
          //   height: 125,
          //   width: 250,
          //   package: 'wayapay_flutter',
          // ),
          Text(
            "Enter your phone number to \n complete payment",
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: (width * height) * 0.00005,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          BaseTextField(
            hintText: "Phone Number",
            controller:controller,
            onChanged: (text) => {

            },
            suffix: Image.asset(
              'assets/images/pay_attitude.png',
              key: const Key("payAttitude"),
              height: 40,
              width: 80,
              package: 'wayapay',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AccentButton(
            key: const Key("PayButton"),
            appState: model.appState,
            onPressed: (){
             pay(context,model);

            },
            text: "Conitnue",
            //showProgress: _validated
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "After clicking the pay now button, kindly check \n your mobile phone to input your pin.",
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: (width * height) * 0.000045,
                color: Colors.grey,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void pay(BuildContext context, TransactionProvider model) {
    if(controller.text.trim().length==11){
     model.payAttitudePayment(controller.text).then((value){
       if(value!=null){
        model.postPayAttitude(value.body.data);
        Future.delayed(const Duration(seconds:1 ),(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PayAttitudeComplete()));
        });
       }
     });
    }else{
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message:
          "Enter a valid mobile number",
        ),
      );
    }
  }
}
