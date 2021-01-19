package com.vincent.wanflutter.activity

import android.content.Intent
import com.vincent.wanflutter.R
import com.vincent.wanflutter.base.BaseActivity


import android.os.Bundle
import android.view.Window
import android.view.WindowManager
import com.vincent.wanflutter.util.TIME_SPLASH_DELAY
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import java.util.concurrent.TimeUnit


class SplashActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestWindowFeature(Window.FEATURE_NO_TITLE)
        window.setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN
        )
        setContentView(R.layout.activity_splash)
        Observable.timer(TIME_SPLASH_DELAY, TimeUnit.MILLISECONDS).subscribeOn(Schedulers.io())
            .unsubscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread())
            .subscribe {
                startActivity(Intent(this@SplashActivity, MainActivity::class.java))
                finish()
                overridePendingTransition(R.anim.anim_zoom_in, R.anim.anim_zoom_out)
            }


    }
}