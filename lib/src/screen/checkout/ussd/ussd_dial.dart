import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wayapay/src/models/ussd_model.dart';
import 'package:wayapay/src/screen/main_page/footer.dart';
import 'package:wayapay/src/screen/main_page/top.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/button.dart';

class UssdDial extends StatelessWidget {
  final Ussd ussd;
  const UssdDial({Key? key, required this.ussd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width!;
    double height = MediaQuery.of(context).size.height!;
    return Scaffold(
     appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left:30,right: 30,top: 20 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            const CheckoutTop(),
            SizedBox(
              height: height * 0.12,
            ),
            Text(
              """Copy the following code below to your \n
          mobile device and dial to complete this\n
    transaction with GTBank""",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: (width * height) * 0.000045,
                    height: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.042,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  ussd.data.responseDetails.ussdString,
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: (width * height) * 0.00006,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  color: Colors.black26,
                  onPressed: () => {
                    copyToClipboard(ussd.data.responseDetails.ussdString,context)
                  },
                ),
              ],
            ),
            SizedBox(
              height: height * 0.042,
            ),
            Text(
              "Click the button below if you have \n made payment",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: (width * height) * 0.000045,
                  color: Colors.black54,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            AccentButton(
                key: const Key("paymentMadeButton"),
                onPressed: () => {
                 // Navigator.of(context).pop(),
                },
                text: "I have made payment",
                showProgress: false),
            SizedBox(
              height: height * 0.12,
            ),
            const CheckoutFooter()
          ],

        ),
      ),
    );
  }

  copyToClipboard(String text,BuildContext context)  {
    Clipboard.setData(ClipboardData(text: text)).then((value){
      showTopSnackBar(
        context,
        const CustomSnackBar.info(
          message: "Copied to clipboard",
        ),
      );
    });

  }
}
