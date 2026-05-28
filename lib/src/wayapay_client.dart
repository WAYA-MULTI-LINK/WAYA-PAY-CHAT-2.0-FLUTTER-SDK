import 'dart:convert';
import 'package:http/http.dart' as http;

import 'wayapay_environment.dart';
import 'wayapay_models.dart';

/// Dart client for the WayaPay API.
///
/// Mirrors the original Node REST client: initialize payments, initiate
/// payouts, verify transactions, fetch the bank list, and verify accounts.
///
/// ```dart
/// final client = WayaPayClient(
///   merchantId: 'MERCH_123',
///   publicKey: 'sk_test_xxx',
///   environment: WayaPayEnvironment.development,
/// );
/// ```
class WayaPayClient {
  final String merchantId;
  final String publicKey;
  final WayaPayEnvironment environment;
  final String baseUrl;
  final String defaultPaymentLink;

  /// Injectable for testing. Defaults to a real [http.Client].
  final http.Client _http;

  WayaPayClient({
    required this.merchantId,
    required this.publicKey,
    required this.environment,
    http.Client? httpClient,
  })  : assert(merchantId != '', 'merchantId is required'),
        assert(publicKey != '', 'publicKey is required'),
        baseUrl = WayaPayConfig.baseUrl(environment),
        defaultPaymentLink = WayaPayConfig.paymentLink(environment),
        _http = httpClient ?? http.Client();

  /// Convenience constructor matching the original string-based env arg.
  factory WayaPayClient.fromStrings({
    required String merchantId,
    required String publicKey,
    required String environment,
    http.Client? httpClient,
  }) {
    if (merchantId.isEmpty || publicKey.isEmpty || environment.isEmpty) {
      throw ArgumentError(
        'merchantId, publicKey, and environment mode is required',
      );
    }
    return WayaPayClient(
      merchantId: merchantId,
      publicKey: publicKey,
      environment: WayaPayEnvironment.fromString(environment),
      httpClient: httpClient,
    );
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Merchant-ID': merchantId,
        'API-Secret-Key': publicKey,
      };

  /// Build the hosted payment link for a transaction id.
  String paymentLinkFor(String transactionId) =>
      '$defaultPaymentLink$transactionId';

  /// Initialize a payment collection.
  Future<WayaPayResult> initializePayment(
      InitializePaymentPayload payload) async {
    return _post('/payment-collect/initiate', payload.toJson(),
        unwrapData: true);
  }

  /// Initiate a payout to a bank account.
  ///
  /// Verify the destination with [verifyAccount] before calling this.
  Future<WayaPayResult> initiatePayout(InitiatePayoutPayload payload) async {
    // Original returns the full response body (not unwrapped) for payout.
    return _post('/payment-payout/initiate', payload.toJson(),
        unwrapData: false);
  }

  /// Verify a transaction status by its reference.
  Future<WayaPayResult> verifyTransaction(String transactionRef) async {
    if (transactionRef.isEmpty) {
      return WayaPayResult.failure('transactionRef is required');
    }
    return _get(
      '/payment/transaction?ref=${Uri.encodeQueryComponent(transactionRef)}',
      unwrapData: true,
    );
  }

  /// Fetch the supported bank list with codes.
  Future<WayaPayResult> fetchBankList() async {
    return _get('/banks-list', unwrapData: true);
  }

  /// Resolve an account number against a bank and return the account name.
  ///
  /// Note: the original sends a body on a GET. Many servers ignore GET bodies,
  /// so this also appends the values as query params for safety.
  Future<WayaPayResult> verifyAccount(VerifyAccountPayload payload) async {
    final qp = Uri(queryParameters: {
      'accountNumber': payload.accountNumber,
      'bankCode': payload.bankCode,
    }).query;
    return _get('/account-verification?$qp',
        body: payload.toJson(), unwrapData: true);
  }

  // ---- internals -------------------------------------------------------

  Future<WayaPayResult> _post(
    String path,
    Map<String, dynamic> body, {
    required bool unwrapData,
  }) async {
    try {
      final res = await _http.post(
        Uri.parse('$baseUrl$path'),
        headers: _headers,
        body: jsonEncode(body),
      );
      return _handle(res, unwrapData: unwrapData);
    } catch (e) {
      return WayaPayResult.failure(e.toString());
    }
  }

  Future<WayaPayResult> _get(
    String path, {
    Map<String, dynamic>? body,
    required bool unwrapData,
  }) async {
    try {
      final req = http.Request('GET', Uri.parse('$baseUrl$path'))
        ..headers.addAll(_headers);
      if (body != null) req.body = jsonEncode(body);
      final streamed = await _http.send(req);
      final res = await http.Response.fromStream(streamed);
      return _handle(res, unwrapData: unwrapData);
    } catch (e) {
      return WayaPayResult.failure(e.toString());
    }
  }

  WayaPayResult _handle(http.Response res, {required bool unwrapData}) {
    dynamic decoded;
    try {
      decoded = res.body.isEmpty ? null : jsonDecode(res.body);
    } catch (_) {
      decoded = res.body;
    }

    final ok = res.statusCode >= 200 && res.statusCode < 300;

    if (!ok) {
      // Surface the server error body, matching the original error?.response?.data.
      final msg = (decoded is Map && decoded['message'] is String)
          ? decoded['message'] as String
          : 'Request failed with status ${res.statusCode}';
      final code = (decoded is Map && decoded['code'] is int)
          ? decoded['code'] as int
          : res.statusCode;
      return WayaPayResult.failure(msg, code: code, raw: decoded);
    }

    final data = (unwrapData && decoded is Map && decoded.containsKey('data'))
        ? decoded['data']
        : decoded;
    return WayaPayResult.success(data, raw: decoded);
  }

  /// Close the underlying HTTP client when done.
  void close() => _http.close();
}