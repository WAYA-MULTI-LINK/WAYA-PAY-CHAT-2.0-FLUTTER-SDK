# WayaPay

A Dart/Flutter client for the WayaPay payment collection and payout API. A direct port of the WayaPay Node REST client.

## Install

```yaml
dependencies:
  wayapay:
    path: ./wayapay   # or your pub.dev / git source
```

## Setup

```dart
import 'package:wayapay/wayapay.dart';

final client = WayaPayClient(
  merchantId: 'YOUR_MERCHANT_ID',
  publicKey: 'YOUR_API_SECRET_KEY',
  environment: WayaPayEnvironment.development, // or .production
);
```

String-based constructor (matches the original Node signature):

```dart
final client = WayaPayClient.fromStrings(
  merchantId: 'YOUR_MERCHANT_ID',
  publicKey: 'YOUR_API_SECRET_KEY',
  environment: 'production', // 'prod' | 'production' | 'dev' | 'development'
);
```

## Initialize a payment

```dart
final res = await client.initializePayment(
  InitializePaymentPayload(
    currency: 'NGN',
    amount: 5000,
    callBackUrl: 'https://yourapp.com/callback',
    idempotencyKey: 'unique-key-123',
    paymentRef: 'order-001',
    metadata: PaymentMetadata(
      firstName: 'Ada',
      lastName: 'Lovelace',
      phoneNumber: '08000000000',
      emailAddress: 'ada@example.ng',
      cancelUrl: 'https://yourapp.com/cancel', // optional
    ),
  ),
);

if (res.isSuccess) {
  final txnId = (res.data as Map)['transactionId'];
  final link = client.paymentLinkFor(txnId);
}
```

## Verify an account, then pay out

```dart
final verify = await client.verifyAccount(
  VerifyAccountPayload(accountNumber: '0123456789', bankCode: '058'),
);

if (verify.isSuccess) {
  final payout = await client.initiatePayout(
    InitiatePayoutPayload(
      currency: 'NGN',
      amount: 2500,
      idempotencyKey: 'payout-key-456',
      bankCode: '058',
      accountNumber: '0123456789',
    ),
  );
}
```

## Other calls

```dart
await client.verifyTransaction('TXN_REF');
await client.fetchBankList();
```

Every method returns a `WayaPayResult` with `status`, `data`, `message`, `code`, and `raw`. Check `isSuccess` before reading `data`.

Call `client.close()` when you're finished to release the HTTP client.

## File structure

```
wayapay/
├── lib/
│   ├── wayapay.dart                  # public barrel export
│   └── src/
│       ├── wayapay_client.dart       # the client + HTTP plumbing
│       ├── wayapay_environment.dart  # env enum + base URLs
│       └── wayapay_models.dart       # payloads, metadata, result wrapper
├── test/
│   └── wayapay_client_test.dart
├── pubspec.yaml
└── README.md
```