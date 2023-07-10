import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_android_ios/shared_android_ios_method_channel.dart';

void main() {
  MethodChannelSharedAndroidIos platform = MethodChannelSharedAndroidIos();
  const MethodChannel channel = MethodChannel('shared_android_ios');

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
