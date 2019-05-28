package com.example.myapplication;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import io.flutter.facade.Flutter;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

public class FlutterShowActivity extends AppCompatActivity {
    private static final String BATTERY_CHANNEL = "samples.flutter.io/battery";
    private static final String CHARGING_CHANNEL = "samples.flutter.io/charging";
    private static final String TEST_CHANNEL = "samples.flutter.io/test";
    private MethodChannel testMethodCall;
    private FlutterView flutterView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_flutter_show);
        addFlutterView();
        new EventChannel(getFlutterView(), CHARGING_CHANNEL).setStreamHandler(new EventChannel.StreamHandler() {
            private BroadcastReceiver chargingStateChangeReceiver;

            @Override
            public void onListen(Object o, EventChannel.EventSink events) {
                chargingStateChangeReceiver = new BroadcastReceiver() {
                    @Override
                    public void onReceive(Context context, Intent intent) {
                        int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);
                        if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
                            events.error("UNAVAILABLE", "Charging status unavailable", null);
                        } else {
                            boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                                    status == BatteryManager.BATTERY_STATUS_FULL;
                            events.success(isCharging ? "charging" : "discharging");
                        }
                    }
                };
                registerReceiver(
                        chargingStateChangeReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            }

            @Override
            public void onCancel(Object o) {
                unregisterReceiver(chargingStateChangeReceiver);
                chargingStateChangeReceiver = null;

            }
        });

        testMethodCall = new MethodChannel(getFlutterView(), TEST_CHANNEL);
        /**
         * 监听 flutter的方法调用
         */
        testMethodCall.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                if (methodCall.method.equals("method1")) {
                    //返回flutter数据
                    result.success("test1_result");
                    Toast.makeText(FlutterShowActivity.this, "flutter调用了java方法", Toast.LENGTH_SHORT).show();
                }
            }
        });


        /**
         * 调用flutter的方法
         */
        findViewById(R.id.btn_call_flutter01).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                testMethodCall.invokeMethod("flutter_method1", null, new MethodChannel.Result() {
                    @Override
                    public void success(Object o) {
                        Toast.makeText(FlutterShowActivity.this, o.toString(), Toast.LENGTH_SHORT).show();
                    }

                    @Override
                    public void error(String s, String s1, Object o) {
                    }

                    @Override
                    public void notImplemented() {

                    }
                });
            }
        });

        new MethodChannel(getFlutterView(), BATTERY_CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("getBatteryLevel")) {
                            int batteryLevel = getBatteryLevel();

                            if (batteryLevel != -1) {
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null);
                            }
                        } else {
                            result.notImplemented();
                        }
                    }
                }
        );
    }

    private void addFlutterView() {
        flutterView = Flutter.createView(
                FlutterShowActivity.this,
                getLifecycle(),
                "route1"
        );

        LinearLayout.LayoutParams layout = new LinearLayout.LayoutParams(600, 800);
        layout.leftMargin = 100;
        layout.topMargin = 200;
        addContentView(flutterView, layout);
    }

    private BinaryMessenger getFlutterView() {
        return flutterView;
    }


    private int getBatteryLevel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            return (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
    }
}
