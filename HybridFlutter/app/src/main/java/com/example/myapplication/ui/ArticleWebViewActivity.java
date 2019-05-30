package com.example.myapplication.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import android.view.KeyEvent;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import com.example.myapplication.R;
import com.just.agentweb.AgentWeb;


public class ArticleWebViewActivity extends Activity {


    static  void start(Context context, String url){
        Intent intent = new Intent(context,ArticleWebViewActivity.class);
        intent.putExtra("url",url);
        context.startActivity(intent);
    }

    private  FrameLayout mWebContainer;
    private String mUrl;
    private AgentWeb mWebViewAgent;

    @Override
    protected void onPause() {
        mWebViewAgent.getWebLifeCycle().onPause();
        super.onPause();
    }

    @Override
    protected void onResume() {
        mWebViewAgent.getWebLifeCycle().onResume();
        super.onResume();
    }

    @Override
    public void onDestroy() {
        mWebViewAgent.getWebLifeCycle().onDestroy();
        super.onDestroy();
    }

    @Override
    protected void onCreate( Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_article_webview);
        mWebContainer = findViewById(R.id.fl_container);

        mUrl = getIntent().getStringExtra("url");
        mWebViewAgent = AgentWeb.with(this)
                .setAgentWebParent(mWebContainer, new LinearLayout.LayoutParams(-1, -1))
                .useDefaultIndicator()
                .createAgentWeb()
                .ready()
                .go(mUrl);

        WebView mWebView = mWebViewAgent.getWebCreator().getWebView();
        WebSettings settings = mWebView.getSettings();
        settings.setBlockNetworkImage(false);
        settings.setAppCacheEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setDatabaseEnabled(true);
        settings.setCacheMode(WebSettings.LOAD_DEFAULT);

        settings.setJavaScriptEnabled(true);
        settings.setSupportZoom(true);
        settings.setBuiltInZoomControls(true);
        //不显示缩放按钮
        settings.setDisplayZoomControls(false);
        //设置自适应屏幕，两者合用
        //将图片调整到适合WebView的大小
        settings.setUseWideViewPort(true);
        //缩放至屏幕的大小
        settings.setLoadWithOverviewMode(true);
        //自适应屏幕
        settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        return mWebViewAgent.handleKeyEvent(keyCode, event) || super.onKeyDown(keyCode, event);
    }


}
