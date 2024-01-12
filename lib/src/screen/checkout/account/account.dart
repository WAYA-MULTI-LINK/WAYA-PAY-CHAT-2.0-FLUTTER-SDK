import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayapay/src/screen/checkout/account/login.dart';

class AccountPayment extends StatelessWidget {
  const AccountPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text1 = 'Click here to login to you wayabank account and complete payment';
    var text2 = 'Kindly click here to generate QR Code for your payment';
    return Padding(
      padding: const EdgeInsets.only(left:30,right: 30,top: 20,bottom: 20 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          paymentMethod(
             'Login to Pay',
              text1,
              onTap: (){
                
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
              }
          ),
          const SizedBox(height: 15,),
          // paymentMethod(
          //     'Scan to Pay',
          //     text2,
          //     onTap: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const QrCode()));
          //     }
          // ),

        ],
      ),
    );
  }

  Widget paymentMethod(String title, String desc,{required Function() onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey[300]!,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset("assets/images/waya.png",package: 'wayapay',),
              const SizedBox(width:20 ,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      desc,
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width:20 ,),
             const Icon(Icons.arrow_forward_rounded,color: Colors.grey,)
            ],
          ),
        ),
      ),
    );
  }
}
