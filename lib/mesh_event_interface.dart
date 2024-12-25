import 'package:mesh_base/mesh_event_channel.dart';

abstract class MeshEventPlatform {
  static MeshEventPlatform _instance = EventChannelMesh();

  static MeshEventPlatform get instance => _instance;

  startListening(void Function(String e));
}
