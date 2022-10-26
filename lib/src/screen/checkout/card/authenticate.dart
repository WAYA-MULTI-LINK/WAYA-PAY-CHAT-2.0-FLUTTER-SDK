import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/models/card.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/checkout/card/transaction_web-view.dart';
import 'package:wayapay/src/screen/main_page/footer.dart';
import 'package:wayapay/src/screen/main_page/top.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/button.dart';

class AuthenticateCard extends StatelessWidget {
  final String pin;
   final  PaymentCard paymentCard;
  const AuthenticateCard({Key? key, required this.pin, required this.paymentCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     var model = context.read<TransactionProvider>();
      //    model.startTransaction();
      //
      //
      //   },
      // ),
      
      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            const SizedBox(
              height: 30,
            ),
            const CheckoutTop(),
            SizedBox(
              height: height * 0.092,
            ),
            Image.asset(
              'assets/images/3ds.png',
              key: const Key("IssuerIcon"),
              height: height * 0.17,
              width: width * 0.17,
              package: 'wayapay',
            ),

            Text(
              "Kindly click the button below to \nauthenticate with your bank",
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: (width * height) * 0.00004)),
            ),
            const SizedBox(
              height: 30,
            ),
            AccentButton(
              text: "Authenticate",
              appState: context.watch<TransactionProvider>().appState,
              fontSize: (width * height) * 0.00004,
              onPressed: () {
                 checkCard(context, paymentCard, pin);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade200, width: 3),
              ),
              onPressed: () {
                 Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.dmSans(
                  color: Colors.grey,
                  fontSize: (width * height) * 0.00004,
                ),
              ),
            ),
            const Spacer(),
            const CheckoutFooter(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  checkCard(BuildContext context,PaymentCard paymentCard,String pin)async{
    var model = context.read<TransactionProvider>();
    var encryptData = await model.encryptCard("${paymentCard.number}|${paymentCard.cvc}");
    if(encryptData!=null){
      var encrpt = await model.processCardPayment(paymentCard, encryptData, pin);

     if(encrpt!=null){
       var html = await model.processCard(encrpt!.body.data,model.customerCharge!.data.tranId);
      if(html!=null){
        Navigator.push(context, MaterialPageRoute(builder:(context)=>CardWebView(
          htmlData: html,) ));
      }
     }
    }

  }
}
