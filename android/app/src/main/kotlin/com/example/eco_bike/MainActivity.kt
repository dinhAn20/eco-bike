package com.example.eco_bike

import android.view.WindowManager.LayoutParams
import android.os.Bundle
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.eco_bike/screen"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "setBrightness") {
                    val args = call.arguments as Map<*, *>
                    val brightness = (args["value"] as Double).toFloat()

                    runOnUiThread {
                        val layoutParams = window.attributes
                        layoutParams.screenBrightness = brightness
                        window.attributes = layoutParams
                    }
                    result.success(null)
                } else if (call.method == "getDeviceInfo") {
                    val info = mapOf(
                        "brand" to Build.BRAND,
                        "model" to Build.MODEL,
                        "device" to Build.DEVICE,
                        "version" to Build.VERSION.RELEASE,
                        "sdk" to Build.VERSION.SDK_INT.toString()
                    )
                    result.success(info)
                } else {
                    result.notImplemented()
                }
            }
    }
}
