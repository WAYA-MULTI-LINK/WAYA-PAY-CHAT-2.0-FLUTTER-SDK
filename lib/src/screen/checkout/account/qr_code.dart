import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/models/qr_code_data.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/main_page/footer.dart';
import 'package:wayapay/src/screen/main_page/top.dart';
import 'package:wayapay/src/widget/appbar.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  QrCodeData? qrCodeData;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var model = context.watch<TransactionProvider>();
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Column(
          children: [
            Row(),
            const SizedBox(height: 40,),
            const CheckoutTop(),
            SizedBox(height: size.height*0.07,),
            Text(
              "Scan the generated QR Code below using your Wayabank Mobile App to complete the payment.",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: size.height*0.07,),
            Container(
              color: Colors.yellow,
              height: size.height*0.2,
              width: 181,
            ),
            SizedBox(height: size.height*0.07,),
            Text(
              "You have 60 seconds left",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ),
            const  Spacer(),
            const CheckoutFooter(),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(milliseconds:50 ),(){
       getCode();

    });
  }

  getCode(){
    var model = context.read<TransactionProvider>();
    model.getQrCode().then((value){
      setState(() {
        qrCodeData=value;

      });
    });
  }
}
