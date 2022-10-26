import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/checkout/card/input/base_textfield.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var model = context.watch<TransactionProvider>();
    return Scaffold(
      appBar: appBar(context),
     body: Padding(
       padding: const EdgeInsets.only(left:30,right: 30,top: 20,bottom: 20 ),
       child: Form(
         key: key,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Row(),
             const SizedBox(height: 20,),
             Text(
               'Welcome Back',
               style: GoogleFonts.dmSans(
                 textStyle: const TextStyle(
                   fontWeight: FontWeight.w500,
                   fontSize: 21,
                 ),
               ),
             ),
             const SizedBox(height: 40,),
             BaseTextField(
               hintText: "Emai or Phone Number",
               controller:email,
               onChanged: (text) => {

               },
             ),
             const SizedBox(height: 15,),
             BaseTextField(
               hintText: "Password",
               controller:email,
               onChanged: (text) => {

               },
             ),
             const SizedBox(height: 25,),
             AccentButton(
               key: const Key("PayButton"),
               appState: model.appState,
               onPressed: (){
                 login(context,model);

               },
               text: "Log in",
               //showProgress: _validated
             ),
           ],
         ),
       ),
     ),
    );
  }

  void login(BuildContext context, TransactionProvider model) {

  }
}
