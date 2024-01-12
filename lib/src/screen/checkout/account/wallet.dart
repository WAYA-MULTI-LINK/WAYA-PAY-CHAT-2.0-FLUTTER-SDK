import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wayapay/src/models/user_data.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/res/color.dart';
import 'package:wayapay/src/screen/checkout/account/Wallet_pin.dart';
import 'package:wayapay/src/screen/main_page/footer.dart';
import 'package:wayapay/src/utils/extension.dart';
import 'package:wayapay/src/widget/appbar.dart';
import 'package:wayapay/src/widget/button.dart';
import 'package:wayapay/src/widget/dropdown.dart';

class Wallet extends StatefulWidget {
  final UserData userData;
  const Wallet({Key? key, required this.userData}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  WalletData? walletData;
  @override
  Widget build(BuildContext context) {
    var model = context.watch<TransactionProvider>();
    var customer = model.customerCharge!.data;
    var amount = model.charge.amount;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
          child: Column(
            children: [
              const Row(),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/3ds.png',
                key: const Key("IssuerIcon"),
                height: height * 0.17,
                width: width * 0.17,
                package: 'wayapay',
              ),
              Text(
                'You are about send money to ${customer.name} for ${model.charge.description}',
               
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(224, 224, 224, 0.35),
                    borderRadius: BorderRadius.circular(4)),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      row("Amount:", amount.toString().toCurrency()),
                      const SizedBox(
                        height: 7,
                      ),
                      row("Fee:", 0.toString().toCurrency()),
                      const SizedBox(
                        height: 7,
                      ),
                      row("Total Amount:", amount.toString().toCurrency(),
                          isBold: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              walletData == null
                  ? const SizedBox()
                  : Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 102, 52, 0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: const Padding(
                            padding: EdgeInsets.all(13.0),
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: AppColor.mainColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Wallet Balance',
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 102, 52, 0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 3, top: 5),
                            child: Text(
                              walletData!.clrBalAmt.toString().toCurrency(),
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.mainColor,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 30,
              ),
              CustomDropdown<WalletData>(
                onChange: (value, index) {
                  setState(() {
                    walletData = value;
                  });
                },
                dropdownButtonStyle: DropdownButtonStyle(
                  height: height * 0.07,
                  elevation: 1,
                  mainAxisAlignment: MainAxisAlignment.start,
                  backgroundColor: Colors.white,
                  primaryColor: Colors.black87,
                ),
                dropdownStyle: DropdownStyle(
                  borderRadius: BorderRadius.circular(8),
                  elevation: 6,
                  padding: const EdgeInsets.all(5),
                ),
                items: widget.userData.data.wallet.map((wallet) {
                  return DropdownItem<WalletData>(
                    value: wallet,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(wallet.accountNo,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: (width * height) * 0.000038,
                                  color: Colors.black),
                            )),
                        SizedBox(
                          width: width * 0.2,
                        ),
                        Text(wallet.clrBalAmt.toString().toCurrency(),
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: (width * height) * 0.000038,
                                  color: Colors.black),
                            )),
                      ],
                    ),
                  );
                }).toList(),
                child: Text(
                  'Click here to select a wallet provider',
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: (width * height) * 0.000038),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AccentButton(
                key: const Key("PayButton"),
                appState: model.appState,
                onPressed: () {
                  if (walletData != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletPin(
                                  walletData: walletData!,
                                  token: widget.userData.data.token,
                                )));
                  } else {
                    showTopSnackBar(
                      context,
                      const CustomSnackBar.error(
                        message: "Select a wallet",
                      ),
                    );
                  }
                },
                text: "Pay Now",
                //showProgress: _validated
              ),
              SizedBox(
                height: height * 0.045,
              ),
              const CheckoutFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget row(String s, String t, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
              fontSize: 11,
            ),
          ),
        ),
        Text(
          t,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
