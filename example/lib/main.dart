import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mesh_base/mesh_base.dart';

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
  final _meshPlugin = MeshBase();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _meshPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: Home()));
  }
}

class Home extends StatelessWidget {
  final _mesh = MeshBase();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Center(
        child: Text('Running on mesh library\n'),
      ),
      TextButton(
        child: Text('Get Platform version'),
        onPressed: () async {
          String? conf = await _mesh.getPlatformVersion();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(conf ?? 'unknown')));
        },
      ),
      TextButton(
        child: Text('Send Message'),
        onPressed: () async {
          String conf = await _mesh.sendMessage("hello world");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(conf)));
        },
      ),
      TextButton(
        child: Text('Get Events'),
        onPressed: () {
          _mesh.getEvents((String s) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Event recieved: $s")));
          });
        },
      ),
    ]);
  }
}
