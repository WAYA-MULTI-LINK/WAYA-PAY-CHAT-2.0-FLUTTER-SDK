

import 'my_strings.dart';

class WayapayException implements Exception {
  String? message;

  WayapayException(this.message);

  @override
  String toString() {
    if (message == null) return Strings.unKnownError;
    return message!;
  }
}

class AuthenticationException extends WayapayException {
  AuthenticationException(String message) : super(message);
}

class CardException extends WayapayException {
  CardException(String message) : super(message);
}

class ChargeException extends WayapayException {
  ChargeException(String? message) : super(message);
}

class InvalidAmountException extends WayapayException {
  int amount = 0;

  InvalidAmountException(this.amount)
      : super('$amount is not a valid '
            'amount. only positive non-zero values are allowed.');
}

class InvalidEmailException extends WayapayException {
  String? email;

  InvalidEmailException(this.email) : super('$email  is not a valid email');
}

class WayapaySdkNotInitializedException extends WayapayException {
  WayapaySdkNotInitializedException(String message) : super(message);
}

class ProcessingException extends ChargeException {
  ProcessingException()
      : super(
            'A transaction is currently processing, please wait till it concludes before attempting a new charge.');
}
