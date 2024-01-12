
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wayapay/src/models/charge.dart';
import 'package:wayapay/src/models/customer.dart';
import 'package:wayapay/src/models/traansaction_status.dart';

class SuccessTransaction extends StatefulWidget {
 final Charge charge;
 final BuildContext mainContext;
  final CustomerCharge customerCharge;
  const SuccessTransaction({Key? key, required this.charge, required this.customerCharge, required this.mainContext}) : super(key: key);

  @override
  State<SuccessTransaction> createState() => _SuccessTransactionState();
}

class _SuccessTransactionState extends State<SuccessTransaction> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(widget.customerCharge.data.tranId);
    return WillPopScope(
      onWillPop: ()async{
        pop();
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/success_icon.png',
              key: const Key("IssuerIcon"),
              height: height * 0.17,
              width: width * 0.17,
              package: 'wayapay',
            ),
            Text(
              "Payment Successful",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize:17 ,
                  )),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "You Paid NGN ${widget.charge.amount} to ${widget.customerCharge.data.name} \n ",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 12)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Here’s your transaction reference",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 12)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(widget.customerCharge.data.tranId,
                    style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13))),
                IconButton(
                  icon: const Icon(Icons.copy),
                  color: Colors.black26,
                  onPressed: ()  {
                    Clipboard.setData(ClipboardData(text:widget.customerCharge.data.tranId )).then((value){
                      showTopSnackBar(
                        context,
                        const CustomSnackBar.info(
                          message: "Copied to clipboard",
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
            DialogButton(
                key: const Key("okButton"),
                width:115 ,
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                onPressed: () {
                 pop();
                },
                child: Text("Okay",
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: (width * height) * 0.00004,
                    ))),
          ],
        ),
      ),
    );
  }


  pop(){
    Navigator.pop(context);
    Navigator.pop(widget.mainContext,TransactionStatus(
        success: true,
        message: "success",
       transactionId:widget.customerCharge.data.tranId
    ));
  }
}
