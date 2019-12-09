package com.vincent.wanflutter.activity

import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import com.vincent.wanflutter.R
import com.vincent.wanflutter.base.BaseActivity
import com.vincent.wanflutter.util.*
import io.flutter.facade.Flutter
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterView
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : BaseActivity() {

    private lateinit  var mMethodChannel: MethodChannel
    private lateinit var testMethodCall: MethodChannel
    private lateinit var mFlutterView: FlutterView
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        addFlutterView()

        mMethodChannel = MethodChannel(getFlutterView(), METHOD_CHANNEL_WEBVIEW)
        /**
         * 监听 flutter的方法调用
         */
        mMethodChannel.setMethodCallHandler { methodCall, result ->
            if (methodCall.method == METHOD_WEBVIEW) {
                val url = methodCall.arguments as String
                ArticleWebViewActivity.start(this@MainActivity, url)
            } else if (methodCall.method == METHOD_BANNER_DONE) {
                progress_circular.setVisibility(View.GONE)
            }
        }


    }

    private fun addFlutterView() {
        mFlutterView = Flutter.createView(
            this@MainActivity,
            lifecycle, INITIAL_ROUTE

        )
        //避免黑屏
        val layout = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.MATCH_PARENT
        )
        mFlutterView.addFirstFrameListener() {
            ll_flutter_container.visibility = View.VISIBLE
        }
        ll_flutter_container.addView(mFlutterView, layout)

    }
    private fun getFlutterView(): BinaryMessenger {
        return mFlutterView
    }
}
