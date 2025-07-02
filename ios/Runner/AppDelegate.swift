import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "com.example.eco_bike/flashlight"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let flashlightChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

      flashlightChannel.setMethodCallHandler { (call, result) in
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
                result(FlutterError(code: "UNAVAILABLE", message: "No torch available", details: nil))
                return
            }

            do {
                try device.lockForConfiguration()
                if call.method == "turnOn" {
                    try device.setTorchModeOn(level: 1.0)
                } else if call.method == "turnOff" {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
                result(nil)
            } catch {
                result(FlutterError(code: "TORCH_ERROR", message: "Could not control torch", details: nil))
            }}
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
