/// Standard result wrapper. Mirrors the original `{ status, data, message }`
/// shape but typed so callers stop guessing what came back.
class WayaPayResult {
  final bool status;
  final dynamic data;
  final String? message;
  final int? code;
  final dynamic raw;

  const WayaPayResult({
    required this.status,
    this.data,
    this.message,
    this.code,
    this.raw,
  });

  factory WayaPayResult.success(dynamic data, {dynamic raw}) =>
      WayaPayResult(status: true, data: data, raw: raw);

  factory WayaPayResult.failure(String message, {int? code, dynamic raw}) =>
      WayaPayResult(status: false, message: message, code: code, raw: raw);

  bool get isSuccess => status;

  @override
  String toString() =>
      'WayaPayResult(status: $status, message: $message, data: $data)';
}

/// Customer details attached to a payment.
class PaymentMetadata {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;
  final String? cancelUrl;

  const PaymentMetadata({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.emailAddress,
    this.cancelUrl,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'emailAddress': emailAddress,
        if (cancelUrl != null) 'cancelUrl': cancelUrl,
      };
}

/// Payload for [WayaPayClient.initializePayment].
class InitializePaymentPayload {
  final String currency;
  final num amount;
  final String callBackUrl;
  final String idempotencyKey;
  final String paymentRef;
  final PaymentMetadata metadata;

  const InitializePaymentPayload({
    required this.currency,
    required this.amount,
    required this.callBackUrl,
    required this.idempotencyKey,
    required this.paymentRef,
    required this.metadata,
  });

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'amount': amount,
        'callBackUrl': callBackUrl,
        'idempotencyKey': idempotencyKey,
        'paymentRef': paymentRef,
        'metadata': metadata.toJson(),
      };
}

/// Payload for [WayaPayClient.initiatePayout].
class InitiatePayoutPayload {
  final String currency;
  final num amount;
  final String idempotencyKey;
  final String bankCode;
  final String accountNumber;

  const InitiatePayoutPayload({
    required this.currency,
    required this.amount,
    required this.idempotencyKey,
    required this.bankCode,
    required this.accountNumber,
  });

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'amount': amount,
        'idempotencyKey': idempotencyKey,
        'bankCode': bankCode,
        'accountNumber': accountNumber,
      };
}

/// Payload for [WayaPayClient.verifyAccount].
class VerifyAccountPayload {
  final String accountNumber;
  final String bankCode;

  const VerifyAccountPayload({
    required this.accountNumber,
    required this.bankCode,
  });

  Map<String, dynamic> toJson() => {
        'accountNumber': accountNumber,
        'bankCode': bankCode,
      };
}