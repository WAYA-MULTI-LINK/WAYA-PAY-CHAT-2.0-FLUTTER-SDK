import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wayapay/src/common/card_utils.dart';
import 'package:wayapay/src/models/card.dart';
import 'package:wayapay/src/screen/checkout/card/input/base_textfield.dart';
import 'package:wayapay/src/screen/checkout/card/input/formotter.dart';
import 'package:wayapay/src/utils/constants.dart';


class DateFieldInput extends BaseTextField {
  DateFieldInput({
    Key? key,

    required FormFieldSetter<String> onSaved,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          labelText: 'Expiry Date',
          hintText: 'MM/YY',
          validator: validateDate,
          onSaved: onSaved,
          onChanged:onChanged ,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
            CardMonthInputFormatter()
          ],
        );

  static String? _getInitialExpiryMonth(PaymentCard? card) {
    if (card == null) {
      return null;
    }
    if (card.expiryYear == null ||
        card.expiryMonth == null ||
        card.expiryYear == 0 ||
        card.expiryMonth == 0) {
      return null;
    } else {
      return '${card.expiryMonth}/${card.expiryYear}';
    }
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.invalidExpiry;
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(RegExp(r'(/)'))) {
      final date = CardUtils.getExpiryDate(value);
      month = date[0];
      year = date[1];
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if (!CardUtils.isNotExpired(year, month)) {
      return Strings.invalidExpiry;
    }
    return null;
  }
}
