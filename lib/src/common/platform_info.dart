// ignore_for_file: prefer_initializing_formals, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/services.dart';

/// Holds data that's different on Android and iOS
class PlatformInfo {
  final String userAgent;
  final String WayapayBuild;
  final String deviceId;

  static Future<PlatformInfo> fromMethodChannel(MethodChannel channel) async {
    // TODO: Update for every new versions.
    //  And there should a better way to fucking do this
    const pluginVersion = "1.0.0";

    final platform = Platform.operatingSystem;
    String userAgent = "${platform}_Wayapay_$pluginVersion";
    String deviceId = await channel.invokeMethod('getDeviceId') ?? "";
    return PlatformInfo._(
      userAgent: userAgent,
      WayapayBuild: pluginVersion,
      deviceId: deviceId,
    );
  }

  const PlatformInfo._({
    required String userAgent,
    required String WayapayBuild,
    required String deviceId,
  })   : userAgent = userAgent,
        WayapayBuild = WayapayBuild,
        deviceId = deviceId;

  @override
  String toString() {
    return '[userAgent = $userAgent, wayapayBuild = $WayapayBuild, deviceId = $deviceId]';
  }
}
