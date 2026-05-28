/// WayaPay runtime environment.
enum WayaPayEnvironment {
  development,
  production;

  /// Parses a string like "prod", "production", "dev", "development".
  static WayaPayEnvironment fromString(String value) {
    final v = value.trim().toLowerCase();
    if (v == 'production' || v == 'prod') {
      return WayaPayEnvironment.production;
    }
    return WayaPayEnvironment.development;
  }

  bool get isProduction => this == WayaPayEnvironment.production;
}

/// Internal endpoint config keyed by environment.
class WayaPayConfig {
  static const Map<bool, String> _apiBase = {
    true: 'https://services.wayapay.ng',
    false: 'https://services.staging.wayapay.ng',
  };

  static const Map<bool, String> _paymentLink = {
    true: 'https://pay.wayapay.ng/?_tranId=',
    false: 'https://pay.staging.wayapay.ng/?_tranId=',
  };

  static String baseUrl(WayaPayEnvironment env) => _apiBase[env.isProduction]!;

  static String paymentLink(WayaPayEnvironment env) =>
      _paymentLink[env.isProduction]!;
}