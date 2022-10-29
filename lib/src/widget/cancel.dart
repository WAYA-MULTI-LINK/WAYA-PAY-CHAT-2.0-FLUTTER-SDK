import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wayapay/src/widget/button.dart';

class CanCelPayment extends StatelessWidget {
  const CanCelPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
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
              Navigator.of(context).pop(),
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
    );
  }
}
