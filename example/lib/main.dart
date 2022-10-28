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
  String _platformVersion = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: const Text(
                                  'Amount:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          TextField(
                            keyboardType:
                            const TextInputType.numberWithOptions(),
                            controller: controller,
                            style: const TextStyle(
                                 fontSize: 25),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 20, top: 20),
                                child: const Text(
                                  'Email:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          TextField(
                            controller: emailController,
                            style: const TextStyle(
                                fontSize: 25),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                          if (controller.value.text.isNotEmpty) {
                            var charge = Charge(
                                amount: 2,
                                isTest: false,
                                description:"mobile payment",
                                deviceInformation:jsonEncode({'phone':"iphone"}),
                                customer: Customer(name: "chisom Eti", email: "chisometi@gmail.com", phoneNumber: "08103565207"),
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
            ],
          ),
        ),
      ),
    );
  }
}
