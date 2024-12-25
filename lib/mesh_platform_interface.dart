import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mesh_method_channel.dart';

abstract class MeshPlatform extends PlatformInterface {
  /// Constructs a MeshPlatform.
  MeshPlatform() : super(token: _token);

  static final Object _token = Object();

  static MeshPlatform _instance = MethodChannelMesh();

  /// The default instance of [MeshPlatform] to use.
  ///
  /// Defaults to [MethodChannelMeshBase].
  static MeshPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MeshPlatform] when
  /// they register themselves.
  static set instance(MeshPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> sendMessage(String s);
  void getEvent(void Function(String s));
}
