import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wayapay_platform_interface.dart';

/// An implementation of [WayapayPlatform] that uses method channels.
class MethodChannelWayapay extends WayapayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wayapay');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
