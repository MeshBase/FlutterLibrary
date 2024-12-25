import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mesh_base/mesh_event_interface.dart';

class EventChannelMesh extends MeshEventPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final eventChannel = const EventChannel("mesh_event");

  @override
  startListening(void Function(String e) callBack) {
    eventChannel.receiveBroadcastStream().listen(
      (event) {
        print('wazap');
        callBack(event);
      },
      onError: (error) {
        print('Error receiving event: $error');
      },
    );
  }
}
