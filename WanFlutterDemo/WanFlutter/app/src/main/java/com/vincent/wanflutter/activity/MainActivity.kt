package com.vincent.wanflutter.activity

import android.os.Bundle
import android.view.View

import com.vincent.wanflutter.util.*

import io.flutter.plugin.common.MethodChannel

import kotlinx.android.synthetic.main.activity_flutter_main.*
import io.flutter.plugins.GeneratedPluginRegistrant;


import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            METHOD_CHANNEL_WEBVIEW
        ).setMethodCallHandler { methodCall, result ->
            if (methodCall.method == METHOD_WEBVIEW) {
                val url = methodCall.arguments as String
                ArticleWebViewActivity.start(this@MainActivity, url)
            } else if (methodCall.method == METHOD_BANNER_DONE) {
                progress_circular.visibility = View.GONE
            }
        }


    }


}
