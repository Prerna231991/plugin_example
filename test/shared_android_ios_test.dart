import 'package:flutter_test/flutter_test.dart';
import 'package:shared_android_ios/shared_android_ios.dart';
import 'package:shared_android_ios/shared_android_ios_platform_interface.dart';
import 'package:shared_android_ios/shared_android_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSharedAndroidIosPlatform
    with MockPlatformInterfaceMixin
    implements SharedAndroidIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SharedAndroidIosPlatform initialPlatform = SharedAndroidIosPlatform.instance;

  test('$MethodChannelSharedAndroidIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSharedAndroidIos>());
  });

  test('getPlatformVersion', () async {
    SharedAndroidIos sharedAndroidIosPlugin = SharedAndroidIos();
    MockSharedAndroidIosPlatform fakePlatform = MockSharedAndroidIosPlatform();
    SharedAndroidIosPlatform.instance = fakePlatform;

    expect(await sharedAndroidIosPlugin.getPlatformVersion(), '42');
  });
}
