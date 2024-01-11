import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wayapay/src/models/bank_model.dart';
import 'package:wayapay/src/provider/transaction_provider.dart';
import 'package:wayapay/src/screen/checkout/ussd/ussd_dial.dart';
import 'package:wayapay/src/widget/button.dart';
import 'package:wayapay/src/widget/dropdown.dart';

class UssdCheckout extends StatefulWidget {
  const UssdCheckout({Key? key}) : super(key: key);

  @override
  State<UssdCheckout> createState() => _UssdCheckoutState();
}

class _UssdCheckoutState extends State<UssdCheckout> {
  Bank? bankData;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
   var model = context.watch<TransactionProvider>();
    return Padding(
      padding: const EdgeInsets.only(left:30,right: 30,top: 20,bottom: 20 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.052,
          ),
          Text(
            "Pay by dailing USSD Code on \nyour mobile device",
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: (width * height) * 0.00005,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * 0.052,
          ),
          Text(
            "Choose your bank to start the payment",
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: (width * height) * 0.00005,
                fontFamily: "DM Sans",
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * 0.012,
          ),
          CustomDropdown<Bank>(
            onChange: (value, index) {
              setState(() {
                bankData = value;
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
            items: model.banks.map((bank) {
              return DropdownItem<Bank>(
                value: bank,
                child: Text(bank.bankName,
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: (width * height) * 0.000038,
                          color: Colors.black),
                    )),
              );
            }).toList(),
            child: Text(
              'Click here to select a bank provider',
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: (width * height) * 0.000038),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AccentButton(
              key: const Key("PayButton"),
              appState: model.appState,
              onPressed: (){

                getUssd(model,context);
              },
              text: "Conitnue",
              //showProgress: _validated
          ),
        ],
      ),
    );
  }

  void getUssd(TransactionProvider model, BuildContext context)async {
    if(bankData!=null){
      await model.startTransaction();
      model.getUssd(bankData!).then((value){
       if(value!=null){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>UssdDial(ussd: value, 
           bankName: bankData!.bankName,)));
       }
      });
    }else{
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message:
          "Select a bank",
        ),
      );
    }
  }
}
