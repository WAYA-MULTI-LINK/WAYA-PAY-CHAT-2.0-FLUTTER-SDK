
import 'package:flutter/material.dart';


class CheckoutFooter extends StatelessWidget {
  const CheckoutFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Icon(
            Icons.lock_sharp,
            size: width *0.05
        ),

        Padding(  padding: EdgeInsets.fromLTRB(width * 0.029, 0, width * 0.029, 0),),
        Text("Payment Secured By " ,
            style: TextStyle( fontSize: (height * width) * 0.000033,fontFamily: "DM Sans", fontWeight:FontWeight.w400)),
        Text("WayaQuick" ,
            style: TextStyle( fontSize: (height * width) * 0.000033,fontFamily: "DM Sans", fontWeight:FontWeight.w700))
      ],

    );
  }
}
