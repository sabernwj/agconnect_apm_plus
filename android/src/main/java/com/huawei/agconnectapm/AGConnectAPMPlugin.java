/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
 */

package com.huawei.agconnectapm;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.agconnect.AGConnectInstance;
import com.huawei.agconnectapm.constants.ChannelConstants;
import com.huawei.agconnectapm.handlers.MethodHandler;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;

public class AGConnectAPMPlugin implements FlutterPlugin, ActivityAware {
    private FlutterPluginBinding flutterPluginBinding;
    private MethodChannel methodChannel;
    private MethodCallHandler methodCallHandler;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        if (flutterPluginBinding != null) {
            initPlugin(flutterPluginBinding.getBinaryMessenger(), binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        resetHandlers();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        this.flutterPluginBinding = null;
        removeChannels();
        removeHandlers();
    }

    private void initPlugin(BinaryMessenger binaryMessenger, Activity activity) {
        if (AGConnectInstance.getInstance() == null) {
            AGConnectInstance.initialize(activity.getApplicationContext());
        }
        initChannels(binaryMessenger);
        initHandlers(activity);
        setHandlers();
    }

    private void initChannels(BinaryMessenger binaryMessenger) {
        methodChannel = new MethodChannel(binaryMessenger, ChannelConstants.METHOD_CHANNEL);
    }

    private void initHandlers(Activity activity) {
        methodCallHandler = new MethodHandler(activity);
    }

    private void setHandlers() {
        methodChannel.setMethodCallHandler(methodCallHandler);
    }

    private void resetHandlers() {
        methodChannel.setMethodCallHandler(null);
    }

    private void removeChannels() {
        methodChannel = null;
    }

    private void removeHandlers() {
        methodCallHandler = null;
    }
}
