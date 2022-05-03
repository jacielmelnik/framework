package com.example.framework

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "android_app_retain").apply {
            setMethodCallHandler { method, result ->
                if (method.method == "sendToBackground") {
                    moveTaskToBack(true);
                }
            }
        }
    }
}

