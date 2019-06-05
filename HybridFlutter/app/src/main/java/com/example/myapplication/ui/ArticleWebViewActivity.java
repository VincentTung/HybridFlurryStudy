package com.example.myapplication.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import com.example.myapplication.R;
import com.just.agentweb.AgentWeb;
import com.just.agentweb.WebChromeClient;
import com.just.agentweb.WebViewClient;


public class ArticleWebViewActivity extends Activity {

    private  static final int PERCENT = 30;
    static void start(Context context, String url) {
        Intent intent = new Intent(context, ArticleWebViewActivity.class);
        intent.putExtra("url", url);
        context.startActivity(intent);
    }

    private FrameLayout mWebContainer;
    private String mUrl;
    private AgentWeb mWebViewAgent;

    private WebViewClient mWebViewClient = new WebViewClient() {
        @Override
        public void onPageStarted(WebView view, String url, Bitmap favicon) {
        }
    };
    private WebChromeClient mWebChromeClient = new WebChromeClient() {
        @Override
        public void onProgressChanged(WebView view, int newProgress) {
            if (newProgress > PERCENT) {
                findViewById(R.id.loading).setVisibility(View.GONE);
            }
        }
    };

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
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_article_webview);
        mWebContainer = findViewById(R.id.fl_container);

        mUrl = getIntent().getStringExtra("url");
        mWebViewAgent = AgentWeb.with(this)
                .setAgentWebParent(mWebContainer, new LinearLayout.LayoutParams(-1, -1))
                .useDefaultIndicator().setWebChromeClient(mWebChromeClient)
                .setWebViewClient(mWebViewClient)
                .createAgentWeb()
                .ready()
                .go(mUrl);

        webViewSetting(mWebViewAgent.getWebCreator().getWebView());
        findViewById(R.id.iv_back).setOnClickListener(v -> finish());
    }

    private void webViewSetting(WebView webView) {
        WebSettings settings = webView.getSettings();
        settings.setBlockNetworkImage(false);
        settings.setAppCacheEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setDatabaseEnabled(true);
        settings.setCacheMode(WebSettings.LOAD_DEFAULT);

        settings.setJavaScriptEnabled(true);
        settings.setSupportZoom(true);
        settings.setBuiltInZoomControls(true);
        settings.setDisplayZoomControls(false);
        settings.setUseWideViewPort(true);
        settings.setLoadWithOverviewMode(true);
        settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        return mWebViewAgent.handleKeyEvent(keyCode, event) || super.onKeyDown(keyCode, event);
    }


}
