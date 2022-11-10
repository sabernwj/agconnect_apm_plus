/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
 */

package com.huawei.agconnectapm;

import android.content.Context;
import android.os.Bundle;

import androidx.annotation.Nullable;

import com.huawei.agconnect.apms.instrument.AppInstrumentation;

import io.flutter.embedding.android.FlutterActivity;

public class AGConnectAPMActivity extends FlutterActivity {
    @Override
    protected void attachBaseContext(Context newBase) {
        AppInstrumentation.attachBaseContextBegin(newBase);
        super.attachBaseContext(newBase);
        AppInstrumentation.attachBaseContextEnd();
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        AppInstrumentation.applicationCreateBegin(getApplicationContext());
        AppInstrumentation.onActivityCreateBegin(this.getClass().getName());
        super.onCreate(savedInstanceState);
        AppInstrumentation.onActivityCreateEnd();
        AppInstrumentation.applicationCreateEnd();
    }

    @Override
    protected void onStart() {
        AppInstrumentation.onActivityStartBegin(this.getClass().getName());
        super.onStart();
        AppInstrumentation.onActivityStartEnd();
    }

    @Override
    protected void onResume() {
        AppInstrumentation.onActivityResumeBegin(this.getClass().getName());
        super.onResume();
        AppInstrumentation.onActivityResumeEnd();
    }

    @Override
    protected void onRestart() {
        AppInstrumentation.onActivityRestartBegin(this.getClass().getName());
        super.onRestart();
        AppInstrumentation.onActivityRestartEnd();
    }
}