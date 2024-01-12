import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wayapay/src/common/card_utils.dart';
import 'package:wayapay/src/common/constants.dart';
import 'package:wayapay/src/models/card.dart';
import 'package:wayapay/src/screen/checkout/card/input/date_field.dart';
import 'package:wayapay/src/screen/checkout/card/input/number_field.dart';
import 'package:wayapay/src/widget/button.dart';

import 'cvc_field.dart';


class CardInput extends StatefulWidget {
  const CardInput({
    Key? key,
  }) : super(key: key);

  @override
  _CardInputState createState() => _CardInputState();
}

class _CardInputState extends State<CardInput> {
  final _formKey = GlobalKey<FormState>();
  final PaymentCard _paymentCard = PaymentCard();
  var _autoValidate = AutovalidateMode.disabled;

  late TextEditingController numberController;
  bool _validated = false;

  bool _isRememberMeChecked = false;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController();
    numberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  void dispose() {
    super.dispose();
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? width =MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;
    return Form(
      autovalidateMode: _autoValidate,
      key: _formKey,
      child: Column(
        children: <Widget>[
          NumberField(
            key: const Key("CardNumberKey"),
            card: _paymentCard,
            controller: numberController,
            onChanged: (String value) => {
              _paymentCard.number = CardUtils.getCleanedNumber(value),
              _getCardTypeFrmNumber()
            },

            onSaved: (String? value) => {
              _paymentCard.number = CardUtils.getCleanedNumber(value),
            },
            suffix: getCardIcon(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: DateFieldInput(
                  key: const ValueKey("ExpiryKey"),
                  onChanged: (value) {
                  List<int> expiryDate = CardUtils.getExpiryDate(value);
                  _paymentCard.expiryMonth = expiryDate[0];
                  _paymentCard.expiryYear = expiryDate[1];

                  },
                  onSaved: (value) {
                    List<int> expiryDate = CardUtils.getExpiryDate(value);
                    if (kDebugMode) {
                      print(expiryDate[0]);
                      print(expiryDate[1]);
                    }
                  },
                ),
              ),
              Flexible(
                  child: CVCField(
                key: const Key("CVVKey"),
                onChanged: (value)=>{
                  _paymentCard.cvc = CardUtils.getCleanedNumber(value)
                },
                onSaved: (value) {
                  _paymentCard.cvc = CardUtils.getCleanedNumber(value);
                },
              )),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: _isRememberMeChecked,
                  onChanged: (value) {
                    setState(() {
                      _isRememberMeChecked = value!;
                    });

                  },
                  activeColor: Constants.wayapay_color,
                  side: BorderSide(
                    color: Colors.deepOrange.shade200,
                  )),
               Text(
                "Remember Card",
                style: TextStyle(fontWeight: FontWeight.w700 ,
                    fontSize: (width * height) * 0.00004),

              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          AccentButton(
              key: const Key("PayButton"),
              onPressed: _validateInputs,
              text: "Pay now",
              showProgress: _validated),
        ],
      ),
    );
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    String cardType = _paymentCard.getTypeForIIN(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

  void _validateInputs() {
    FocusScope.of(context).requestFocus(FocusNode());
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      //widget.onValidated(_paymentCard);
      if (mounted) {
        setState(() => _validated = true);
      }
    } else {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message:
          "Something went wrong. Please check your entries and try again",
        ),
      );
      setState(() => _autoValidate = AutovalidateMode.always);

    }
    print(_paymentCard.toString());
  }
  Widget getCardIcon(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String img = "";
    var defaultIcon = Icon(
      Icons.credit_card,
      key: const Key("DefaultIssuerIcon"),
      size: (width * height) * 0.00009,
      color: Colors.grey[600],
    );
    switch (_paymentCard.type) {
      case CardType.masterCard:
        img = 'mastercard.png';
        break;
      case CardType.visa:
        img = 'visa.png';
        break;
      case CardType.verve:
        img = 'verve.png';
        break;
      case CardType.americanExpress:
        img = 'american_express.png';
        break;
      case CardType.discover:
        img = 'discover.png';
        break;
      case CardType.dinersClub:
        img = 'dinners_club.png';
        break;
      case CardType.jcb:
        img = 'jcb.png';
        break;
    }
    Widget widget;
    if (img.isNotEmpty) {
      widget = Image.asset(
        'assets/images/$img',
        key: const Key("IssuerIcon"),
        height: height * 0.08,
        width: width * 0.08,
        package: 'wayapay_flutter',
      );
    } else {
      widget = defaultIcon;
    }
    return widget;
  }

}
