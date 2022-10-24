import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wayapay_method_channel.dart';

abstract class WayapayPlatform extends PlatformInterface {
  /// Constructs a WayapayPlatform.
  WayapayPlatform() : super(token: _token);

  static final Object _token = Object();

  static WayapayPlatform _instance = MethodChannelWayapay();

  /// The default instance of [WayapayPlatform] to use.
  ///
  /// Defaults to [MethodChannelWayapay].
  static WayapayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WayapayPlatform] when
  /// they register themselves.
  static set instance(WayapayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
