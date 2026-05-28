import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:wayapay/wayapay.dart';

void main() {
  group('WayaPayClient', () {
    test('resolves environment from string', () {
      final client = WayaPayClient.fromStrings(
        merchantId: 'm',
        publicKey: 'k',
        environment: 'prod',
      );
      expect(client.environment, WayaPayEnvironment.production);
      expect(client.baseUrl, 'https://services.wayapay.ng');
    });

    test('initializePayment unwraps data on success', () async {
      final mock = MockClient((req) async {
        expect(req.headers['Merchant-ID'], 'm');
        return http.Response(
          jsonEncode({
            'data': {'transactionId': 'txn_1'}
          }),
          200,
        );
      });

      final client = WayaPayClient(
        merchantId: 'm',
        publicKey: 'k',
        environment: WayaPayEnvironment.development,
        httpClient: mock,
      );

      final res = await client.initializePayment(
        const InitializePaymentPayload(
          currency: 'NGN',
          amount: 1000,
          callBackUrl: 'https://x.test/cb',
          idempotencyKey: 'idem_1',
          paymentRef: 'ref_1',
          metadata: PaymentMetadata(
            firstName: 'Ada',
            lastName: 'Lovelace',
            phoneNumber: '08000000000',
            emailAddress: 'ada@test.ng',
          ),
        ),
      );

      expect(res.isSuccess, true);
      expect((res.data as Map)['transactionId'], 'txn_1');
    });

    test('verifyTransaction guards empty ref', () async {
      final client = WayaPayClient(
        merchantId: 'm',
        publicKey: 'k',
        environment: WayaPayEnvironment.development,
        httpClient: MockClient((_) async => http.Response('{}', 200)),
      );
      final res = await client.verifyTransaction('');
      expect(res.isSuccess, false);
      expect(res.message, 'transactionRef is required');
    });

    test('surfaces server error body', () async {
      final mock = MockClient((_) async => http.Response(
            jsonEncode({'message': 'invalid key', 'code': 401}),
            401,
          ));
      final client = WayaPayClient(
        merchantId: 'm',
        publicKey: 'k',
        environment: WayaPayEnvironment.development,
        httpClient: mock,
      );
      final res = await client.fetchBankList();
      expect(res.isSuccess, false);
      expect(res.message, 'invalid key');
      expect(res.code, 401);
    });
  });
}