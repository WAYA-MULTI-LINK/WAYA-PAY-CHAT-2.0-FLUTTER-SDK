import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayapay/wayapay_method_channel.dart';

void main() {
  MethodChannelWayapay platform = MethodChannelWayapay();
  const MethodChannel channel = MethodChannel('wayapay');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
