package com.example.eco_bike
import android.hardware.camera2.CameraManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.eco_bike/flashlight"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                val cameraManager = getSystemService(CAMERA_SERVICE) as CameraManager
                val cameraId = cameraManager.cameraIdList[0] // usually back camera

                when (call.method) {
                    "turnOn" -> {
                        cameraManager.setTorchMode(cameraId, true)
                        result.success(null)
                    }
                    "turnOff" -> {
                        cameraManager.setTorchMode(cameraId, false)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
