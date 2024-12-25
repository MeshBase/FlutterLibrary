import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mesh_platform_interface.dart';

/// An implementation of [MeshPlatform] that uses method channels.
class MethodChannelMesh extends MeshPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mesh_method');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String> sendMessage(String str) async {
    String? res = await methodChannel
        .invokeMethod<String>('sendMessage', {"message": str});
    return res ?? "no-result";
  }

  void getEvent(void Function(String s) callBack) async {
    Timer(const Duration(seconds: 1), () => callBack('event1'));
    Timer(const Duration(seconds: 2), () => callBack('event2'));
    Timer(const Duration(seconds: 3), () => callBack('event3'));
  }
}
