package com.example.myapplication.ui;

import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;

import com.example.myapplication.R;
import com.example.myapplication.base.BaseActivity;
import com.mingle.widget.LoadingView;

import io.flutter.facade.Flutter;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

public class FlutterMainActivity extends BaseActivity {
    private static final String METHOD_CHANNEL_WEBVIEW = "com.vincent.wanandroid/article_webview";
    private static final String METHOD_WEBVIEW = "article_detail";
    private static final String METHOD_BANNER_DONE = "banner_done";
    private static final String INITIAL_ROUTE = "route1";
    private FlutterView mFlutterView;
    private LinearLayout ll_flutterViewContainer;
    private LoadingView progressBar;

    private MethodChannel mMethodChannel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_flutter_main);
        ll_flutterViewContainer = findViewById(R.id.ll_flutter_container);
        progressBar = findViewById(R.id.progress_circular);
        addFlutterView();
        mMethodChannel = new MethodChannel(getFlutterView(), METHOD_CHANNEL_WEBVIEW);
        /**
         * 监听 flutter的方法调用
         */
        mMethodChannel.setMethodCallHandler((methodCall, result) -> {
            if (methodCall.method.equals(METHOD_WEBVIEW)) {
                String url = (String) methodCall.arguments;
                ArticleWebViewActivity.start(FlutterMainActivity.this, url);
            } else if (methodCall.method.equals(METHOD_BANNER_DONE)) {
                progressBar.setVisibility(View.GONE);
            }
        });

    }

    private void addFlutterView() {
        mFlutterView = Flutter.createView(
                FlutterMainActivity.this,
                getLifecycle(), INITIAL_ROUTE

        );
        //避免黑屏
        LinearLayout.LayoutParams layout = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        final FlutterView.FirstFrameListener[] listeners = new FlutterView.FirstFrameListener[1];
        listeners[0] = () -> {
            ll_flutterViewContainer.setVisibility(View.VISIBLE);
        };
        mFlutterView.addFirstFrameListener(listeners[0]);
        ll_flutterViewContainer.addView(mFlutterView, layout);

    }

    private BinaryMessenger getFlutterView() {
        return mFlutterView;
    }

}
