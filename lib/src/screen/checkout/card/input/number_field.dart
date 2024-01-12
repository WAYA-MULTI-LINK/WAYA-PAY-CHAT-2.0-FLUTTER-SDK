import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wayapay/src/common/card_utils.dart';
import 'package:wayapay/src/models/card.dart';
import 'package:wayapay/src/screen/checkout/card/input/base_textfield.dart';
import 'package:wayapay/src/screen/checkout/card/input/formotter.dart';
import 'package:wayapay/src/utils/constants.dart';


class NumberField extends BaseTextField {
  NumberField(
      {Key? key,
        required PaymentCard card,
        required TextEditingController? controller,
        required FormFieldSetter<String> onSaved,
        ValueChanged<String>? onChanged,
        required Widget suffix})
      : super(
    key: key,
    labelText: 'Card Number',
    hintText: '0000 0000 0000 0000',
    controller: controller,
    onSaved: onSaved,
    onChanged: onChanged,
    suffix: suffix,
    validator:  (String? value) => validateCardNum(value, card),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(19),
      CardNumberInputFormatter()
    ],
  );

  static String? validateCardNum(String? input, PaymentCard? card) {
    if (input == null || input.isEmpty) {
      return Strings.invalidNumber;
    }

    input = CardUtils.getCleanedNumber(input);
    return card!.validNumber(input) ? null : Strings.invalidNumber;
  }


}
