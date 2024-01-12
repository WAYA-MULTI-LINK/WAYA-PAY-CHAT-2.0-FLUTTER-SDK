import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wayapay/src/models/card.dart';
import 'package:wayapay/src/utils/constants.dart';

import 'base_textfield.dart';


class CVCField extends BaseTextField {
  CVCField({
    Key? key,

    required FormFieldSetter<String> onSaved,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          labelText: 'CVV',
          hintText: '123',
          obscureText: true,
          onChanged: onChanged,
          onSaved: onSaved,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
        );

  static String? validateCVC(String? value, PaymentCard? card) {
    if (value == null || value.trim().isEmpty) return Strings.invalidCVC;
    return card!.validCVC(value) ? null : Strings.invalidCVC;
  }
}
