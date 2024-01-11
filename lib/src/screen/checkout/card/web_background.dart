import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayapay/src/res/color.dart';

class WebBackGround extends StatelessWidget {
  const WebBackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(),
   // Image.asset("assets/images/waya_orange.png",package: 'wayapay',),
     const   SizedBox(height: 20,),
        Text(
          "WAYAQUICK AUTHORIZATION" ,
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
              textStyle: const TextStyle(
                color: AppColor.mainColor,
                  fontWeight: FontWeight.w700,
                  fontSize:22)),
        ),
        const SizedBox(height: 10,),
        Text(
          """ 
Please wait while we connect to your bank.

You’re being redirected to your 
bank to protect your card against
unauthorized use..
          """,
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: (width * height) * 0.00004)),
        ),
      ],
    );
  }
}
