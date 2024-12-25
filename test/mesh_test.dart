import 'package:flutter_test/flutter_test.dart';
import 'package:mesh_base/mesh_base.dart';
import 'package:mesh_base/mesh_method_channel.dart';
import 'package:mesh_base/mesh_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMeshPlatform with MockPlatformInterfaceMixin implements MeshPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MeshPlatform initialPlatform = MeshPlatform.instance;

  test('$MethodChannelMesh is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMesh>());
  });

  test('getPlatformVersion', () async {
    MeshBase meshPlugin = MeshBase();
    MockMeshPlatform fakePlatform = MockMeshPlatform();
    MeshPlatform.instance = fakePlatform;

    expect(await meshPlugin.getPlatformVersion(), '42');
  });
}
