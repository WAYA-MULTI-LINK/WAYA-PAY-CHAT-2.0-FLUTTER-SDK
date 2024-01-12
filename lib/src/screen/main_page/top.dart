import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/utils/extension.dart';


class CheckoutTop extends StatelessWidget {


  const CheckoutTop({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var charge = context.watch<TransactionProvider>().charge;
    return Column(
      children: [
        Text("Amount Payable is",
            style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: (height * width) * 0.00004),

        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3)),
        Text(charge.amount.toString().toCurrency(),
            style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: (height * width) * 0.00009)
            ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3)),
        Text(
          charge.customer.email,
          style: GoogleFonts.lato(
                  fontStyle: FontStyle.normal,
                  color: const Color(0XFF828282),
                  fontWeight: FontWeight.w400,
                  fontSize: (height * width) * 0.00005),
        )
      ],
    );
  }
}
