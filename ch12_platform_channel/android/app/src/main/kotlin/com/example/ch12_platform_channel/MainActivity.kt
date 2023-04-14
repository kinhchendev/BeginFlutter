package com.example.ch12_platform_channel

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        var deviceInfoChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "platformchannel.companyname.com/deviceinfo")
        deviceInfoChannel.setMethodCallHandler { call, result ->
            if (call.method == "getDeviceInfo") {
                var deviceInfo = getDeviceInfo()
                result.success(deviceInfo)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getDeviceInfo(): String {
        return ("\nDevice: " + Build.DEVICE
                + "\nManufacturer: " + Build.MANUFACTURER
                + "\nModel: " + Build.MODEL
                + "\nProduct: " + Build.PRODUCT
                + "\nVersion Release: " + Build.VERSION.RELEASE + "\nVersion SDK: " + Build.VERSION.SDK_INT
                + "\nFingerprint : " + Build.FINGERPRINT)
    }
}
