import 'package:flutter_test/flutter_test.dart';
import 'package:wayapay/wayapay.dart';
import 'package:wayapay/wayapay_platform_interface.dart';
import 'package:wayapay/wayapay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWayapayPlatform
    with MockPlatformInterfaceMixin
    implements WayapayPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WayapayPlatform initialPlatform = WayapayPlatform.instance;

  test('$MethodChannelWayapay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWayapay>());
  });

  test('getPlatformVersion', () async {
    Wayapay wayapayPlugin = Wayapay();
    MockWayapayPlatform fakePlatform = MockWayapayPlatform();
    WayapayPlatform.instance = fakePlatform;

    expect(await wayapayPlugin.getPlatformVersion(), '42');
  });
}
