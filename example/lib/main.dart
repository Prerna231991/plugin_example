import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shared_android_ios/shared_android_ios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _sharedAndroidIosPlugin = SharedAndroidIos();

  @override
  void initState() {
    super.initState();
  //  initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {

          await _sharedAndroidIosPlugin.share("Send data on server") ;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
   /* if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  Text("ConnectCX")
        ),
        body: Center(
          child: ElevatedButton(onPressed: ()async{
            await _sharedAndroidIosPlugin.share("Send data on server") ;

          }, child: Text("Shared Button"))
        ),
      ),
    );
  }
}
