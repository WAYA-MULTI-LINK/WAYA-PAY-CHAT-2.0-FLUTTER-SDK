

class Strings {
  static const emptyStr = ' can be null but it should not be empty';
  static const String fieldReq = 'This field is required';
  static const String invalidNumber = 'Invalid card number';
  static const String invalidExpiry = 'Invalid card expiry';
  static const String invalidCVC = 'Invalid cvv';
  static const String invalidAcc =
      'Please enter a valid 10-digit NUBAN number ';
  static const String continue_ = 'Continue';
  static const String cancel = 'Cancel';
  static const String unKnownError = 'Unknown Error';
  static const String nigerianLocale = 'en_NG';
  static const String ngn = 'NGN';
  static const int currencyCode  = 566;
  static const String noAccessCodeReference =
      'Pass either an access code or transaction '
      'reference';
  static const String sthWentWrong = 'Something went wrong.';
  static const String errorGettingBanks= 'An Error occurred getting Banks';
  static const String userTerminated = 'Transaction terminated';
  static const String unKnownResponse = 'Unknown server response';
  static const String cardInputInstruction = 'Enter your card details to pay';
  static const String baseUrl = 'https://services.wayapay.ng/';
  static const String stagingBaseUrl = 'https://services.staging.wayapay.ng/';
  //Card Transactions
  static const String transactionRequestUrl = 'payment-gateway/api/v1/request/transaction';
  static const String transactionPaymentUrl = 'payment-gateway/api/v1/transaction/payment';
  static const String transactionProcessingUrl = 'payment-gateway/api/v1/transaction/processing';
  static const String cardEncriptionUrl = 'payment-gateway/api/v1/card/encryption';
  static const String transactionStatusUrl = 'payment-gateway/api/v1/reference/query';
    static const String authorizationUrl = 'payment-gateway/api/v1/transaction/authorization';

  //USSD Transactions
  static const String getUssdBanksUrl = 'ussd-service/api/v2/bank/fetch-all';
  static const String ussdTransactionUrl = 'ussd-service/api/v2/transaction';
  static const String ussdTransactionStatusUrl = 'ussd-service/api/v2/transaction/query-ussd-transaction';
  //Pay Attitude
  static const String postPayAttitudeUrl = 'payment-gateway/api/v1/transaction/processing/bank';

//wallet payment
  static const String loginToWallet = 'payment-gateway/api/v1/authentication/wallet';
  static const String makePaymentToWallet = 'payment-gateway/api/v1/wallet/payment';
  static const String getQrcode = 'payment-gateway/api/v1/generate/qr-code';

}
