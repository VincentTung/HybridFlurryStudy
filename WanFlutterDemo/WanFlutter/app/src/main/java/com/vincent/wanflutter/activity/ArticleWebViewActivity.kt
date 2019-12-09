package com.vincent.wanflutter.activity


import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.os.Bundle
import android.view.KeyEvent
import android.view.View

import android.webkit.WebSettings
import android.webkit.WebView

import android.widget.LinearLayout
import com.just.agentweb.AgentWeb
import com.just.agentweb.WebChromeClient
import com.just.agentweb.WebViewClient
import com.vincent.wanflutter.R
import com.vincent.wanflutter.base.BaseActivity
import com.vincent.wanflutter.util.PERCENT
import kotlinx.android.synthetic.main.activity_article_webview.*


class ArticleWebViewActivity : BaseActivity() {

    private var mUrl: String? = null
    private lateinit var mWebViewAgent: AgentWeb


    override fun onPause() {
        mWebViewAgent!!.webLifeCycle.onPause()
        super.onPause()
    }

    override fun onResume() {
        mWebViewAgent!!.webLifeCycle.onResume()
        super.onResume()
    }

    public override fun onDestroy() {
        mWebViewAgent!!.webLifeCycle.onDestroy()
        super.onDestroy()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_article_webview)

        mUrl = intent.getStringExtra("url")
        mWebViewAgent = AgentWeb.with(this)
            .setAgentWebParent(fl_container, LinearLayout.LayoutParams(-1, -1))
            .useDefaultIndicator().setWebChromeClient(object : WebChromeClient() {
                override fun onProgressChanged(view: WebView, newProgress: Int) {
                    if (newProgress > PERCENT) {
                        findViewById<View>(R.id.loading).visibility = View.GONE
                    }
                }
            })
            .setWebViewClient( object : WebViewClient() {
                override fun onPageStarted(view: WebView, url: String, favicon: Bitmap?) {}
            })
            .createAgentWeb()
            .ready()
            .go(mUrl)

        webViewSetting(mWebViewAgent!!.getWebCreator().getWebView())
        findViewById<View>(R.id.iv_back).setOnClickListener { v -> finish() }
    }

    private fun webViewSetting(webView: WebView) {
        val settings = webView.settings
        settings.blockNetworkImage = false
        settings.setAppCacheEnabled(true)
        settings.domStorageEnabled = true
        settings.databaseEnabled = true
        settings.cacheMode = WebSettings.LOAD_DEFAULT

        settings.javaScriptEnabled = true
        settings.setSupportZoom(true)
        settings.builtInZoomControls = true
        settings.displayZoomControls = false
        settings.useWideViewPort = true
        settings.loadWithOverviewMode = true
        settings.layoutAlgorithm = WebSettings.LayoutAlgorithm.SINGLE_COLUMN
    }


    override fun onKeyDown(keyCode: Int, event: KeyEvent): Boolean {
        return mWebViewAgent!!.handleKeyEvent(keyCode, event) || super.onKeyDown(keyCode, event)
    }

    companion object {


        internal fun start(context: Context, url: String) {
            val intent = Intent(context, ArticleWebViewActivity::class.java)
            intent.putExtra("url", url)
            context.startActivity(intent)
        }
    }


}
