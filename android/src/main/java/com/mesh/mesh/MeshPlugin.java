package com.mesh.mesh;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * MeshPlugin
 */
public class MeshPlugin implements FlutterPlugin, MethodCallHandler {
    String KEY = "MeshPlugin";
    private MethodChannel methodChannel;
    private EventChannel.EventSink eventSink = null;


    public void sendEvent(String s) {
        if (eventSink != null) {
            Log.d(KEY, "sending event:" + s);
            new Handler(
                    Looper.getMainLooper()
            ).post(() -> eventSink.success(s));
        } else {
            throw new RuntimeException("eventSink is null");
        }
    }

    public void startRandomEvents() {
        new Thread(() -> {
            for (int i = 1; i <= 5; i++) {
                try {
                    sendEvent("Event " + i);
                    Thread.sleep(1000); // Simulate some delay
                } catch (InterruptedException | RuntimeException e) {
                    Log.e(KEY, "Error sending event", e);
                }
            }
        }).start();
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        Log.d(KEY, "in on attached to engine");
        methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mesh_method");
        methodChannel.setMethodCallHandler(this);

        MeshPlugin meshPlugin = this;
        EventChannel eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "mesh_event");
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink eventSink) {
                Log.d(KEY, "in on listen");
                meshPlugin.eventSink = eventSink;
                startRandomEvents();
            }

            @Override
            public void onCancel(Object arguments) {
                eventSink.endOfStream();
                meshPlugin.eventSink = null;
            }
        });
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("sendMessage")) {
            Log.d(KEY, "sending message");
            String msg = call.argument("message");
            result.success(msg + "from java");
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
    }
}

