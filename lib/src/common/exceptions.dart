

import 'package:wayapay/src/utils/constants.dart';



class WayaPayException implements Exception {
  String? message;

  WayaPayException(this.message);

  @override
  String toString() {
    if (message == null) return Strings.unKnownError;
    return message!;
  }
}

class AuthenticationException extends WayaPayException {
  AuthenticationException(String message) : super(message);
}

class CardException extends WayaPayException {
  CardException(String message) : super(message);
}

class ChargeException extends WayaPayException {
  ChargeException(String? message) : super(message);
}

class InvalidAmountException extends WayaPayException {
  int amount = 0;

  InvalidAmountException(this.amount)
      : super('$amount is not a valid '
            'amount. only positive non-zero values are allowed.');
}

class InvalidEmailException extends WayaPayException {
  String? email;

  InvalidEmailException(this.email) : super('$email  is not a valid email');
}

class WayapaySdkNotInitializedException extends WayaPayException {
  WayapaySdkNotInitializedException(String message) : super(message);
}

class ProcessingException extends ChargeException {
  ProcessingException()
      : super(
            'A transaction is currently processing, please wait till it concludes before attempting a new charge.');
}
