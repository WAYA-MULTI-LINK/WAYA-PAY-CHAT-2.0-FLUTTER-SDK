import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';


import 'package:wayapay/wayapay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _wayapayPlugin = Wayapay();
  final  TextEditingController controller = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: key,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType:
                    const TextInputType.numberWithOptions(),
                    validator: (e){
                      if(e!.isEmpty){
                        return "enter amount";
                      }
                      return null;
                    },
                    controller: controller,
                    style: const TextStyle(
                        fontSize: 25),
                    decoration: const InputDecoration(
                      labelText: "amount"
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    controller: emailController,
                    validator: (e){
                      if(e!.length<4){
                        return "enter email";
                      }
                      return null;
                    },
                    style: const TextStyle(
                        fontSize: 25),
                    decoration: const InputDecoration(
                      labelText: "email"
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: const Color(0xff1b447b),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: 100,
                      child: const Text(
                        'PAY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        var charge = Charge(
                            amount: int.parse(controller.text),
                            isTest: false,
                            description:"mobile payment",
                            deviceInformation:jsonEncode({'phone':"iphone"}),
                            customer: Customer(name: "chisom Eti", email: emailController.text, phoneNumber: "08103565207"),
                            merchantId: 'MER_3zUWo1656418606145pYewf',
                            wayaPublicKey: "WAYAPUBK_PROD_0x271b51f9ec964a59a4438ddf2f71cea0"
                        );
                        _wayapayPlugin.checkout(context,charge);

                      } else {
                        debugPrint('invalid!');
                      }
                    },
                  ),
                        ],
                      ),
            ),
                  ),
        ),
              ),

          );

  }
}
