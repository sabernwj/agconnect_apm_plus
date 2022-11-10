/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
 */

package com.huawei.agconnectapm.handlers;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.agconnectapm.constants.MethodConstants;
import com.huawei.agconnectapm.exception.AGConnectAPMException;
import com.huawei.agconnectapm.modules.AGConnectAPMModule;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MethodHandler implements MethodCallHandler {
    private final Activity activity;

    public MethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        try {
            final AGConnectAPMModule module = AGConnectAPMModule.getInstance(activity);
            switch (call.method) {
                case MethodConstants.ENABLE_COLLECTION:
                    module.enableCollection(call, result);
                    break;
                case MethodConstants.ENABLE_ANR_MONITOR:
                    module.enableAnrMonitor(call, result);
                    break;
                case MethodConstants.CREATE_CUSTOM_TRACE:
                    module.createCustomTrace(call, result);
                    break;
                case MethodConstants.CREATE_NETWORK_MEASURE:
                    module.createNetworkMeasure(call, result);
                    break;
                case MethodConstants.SET_USER_IDENTIFIER:
                    module.setUserIdentifier(call, result);
                    break;
                case MethodConstants.CUSTOM_TRACE_INNER:
                    module.customTraceInner(call, result);
                    break;
                case MethodConstants.NETWORK_MEASURE_INNER:
                    module.networkMeasureInner(call, result);
                    break;
                default:
                    result.notImplemented();
            }
        } catch (RuntimeException | AGConnectAPMException e) {
            final AGConnectAPMException exception = AGConnectAPMException.from(e);
            result.error(exception.getErrorCode(), exception.getErrorMessage(), exception.getErrorDetails());
        }
    }
}
