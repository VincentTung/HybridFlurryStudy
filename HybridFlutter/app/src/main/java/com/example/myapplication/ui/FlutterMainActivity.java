package com.example.myapplication.ui;

import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.ProgressBar;

import com.example.myapplication.R;
import com.example.myapplication.base.BaseActivity;

import java.util.concurrent.TimeUnit;

import io.flutter.facade.Flutter;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.view.FlutterView;
import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

public class FlutterMainActivity extends BaseActivity {

    private static final String INITIAL_ROUTE = "route1";
    private FlutterView mFlutterView;
    private long TIME_LOADING_FLUTTER_VIEW = 2000L;
    private LinearLayout ll_flutterViewContainer;
    private ProgressBar progressBar;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_flutter_main);
        ll_flutterViewContainer = findViewById(R.id.ll_flutter_container);
        progressBar = findViewById(R.id.progress_circular);
        addFlutterView();
        Observable.timer(TIME_LOADING_FLUTTER_VIEW, TimeUnit.MILLISECONDS).
                subscribeOn(Schedulers.io()).unsubscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribe(aLong -> {
            progressBar.setVisibility(View.GONE);

        });

    }

    private void addFlutterView() {
        mFlutterView = Flutter.createView(
                FlutterMainActivity.this,
                getLifecycle(), INITIAL_ROUTE

        );
        LinearLayout.LayoutParams layout = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        ll_flutterViewContainer.addView(mFlutterView, layout);


    }

    private BinaryMessenger getFlutterView() {
        return mFlutterView;
    }

}
