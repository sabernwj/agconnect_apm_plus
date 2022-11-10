/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
 */

package com.huawei.agconnectapm.modules;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.huawei.agconnect.AGConnectInstance;
import com.huawei.agconnect.apms.APMS;
import com.huawei.agconnect.apms.collect.HiAnalyticsManager;
import com.huawei.agconnect.apms.custom.CustomTrace;
import com.huawei.agconnect.apms.custom.NetworkMeasure;
import com.huawei.agconnect.apms.f1;
import com.huawei.agconnect.apms.l1;
import com.huawei.agconnectapm.constants.KeyConstants;
import com.huawei.agconnectapm.constants.MethodConstants;
import com.huawei.agconnectapm.exception.AGConnectAPMException;
import com.huawei.hms.analytics.HiAnalytics;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;

public class AGConnectAPMModule {
    private static volatile AGConnectAPMModule instance;
    private final Map<String, CustomTrace> customTraceMap = new HashMap<>();
    private final Map<String, NetworkMeasure> networkMeasureMap = new HashMap<>();

    public static AGConnectAPMModule getInstance(Activity activity) throws AGConnectAPMException {
        if (instance == null) {
            try {
                if (AGConnectInstance.getInstance() == null) {
                    AGConnectInstance.initialize(activity.getApplicationContext());
                }
                APMS.getInstance().start(activity.getApplicationContext());
                instance = new AGConnectAPMModule();
                HiAnalyticsManager.getInstance().init(activity.getApplicationContext());
//                l1 analyInstance=f1.abc(activity.getApplicationContext(), "APMS", "com.huawei.agconnect.apms");
//                HiAnalyticsManager.getInstance().analyticsInternalInstance= analyInstance;
            } catch (RuntimeException e) {
                throw AGConnectAPMException.from(e);
            }
        }
        return instance;
    }

    public void enableCollection(@NonNull MethodCall call, @NonNull Result result) throws AGConnectAPMException {
        try {
            final boolean enable = Objects.requireNonNull(call.argument(KeyConstants.ENABLE));

            APMS.getInstance().enableCollection(enable);

            result.success(true);
        } catch (RuntimeException e) {
            throw AGConnectAPMException.from(e);
        }
    }

    public void enableAnrMonitor(@NonNull MethodCall call, @NonNull Result result) throws AGConnectAPMException {
        try {
            final boolean enable = Objects.requireNonNull(call.argument(KeyConstants.ENABLE));

            APMS.getInstance().enableAnrMonitor(enable);
            result.success(true);
        } catch (RuntimeException e) {
            throw AGConnectAPMException.from(e);
        }
    }

    public void createCustomTrace(@NonNull MethodCall call, @NonNull Result result) throws AGConnectAPMException {
        try {
            final String customTraceName = Objects.requireNonNull(call.argument(KeyConstants.CUSTOM_TRACE_NAME));

            final CustomTrace customTrace = APMS.getInstance().createCustomTrace(customTraceName);
            final String customTraceId = generateUniqueId(customTraceMap.keySet());
            customTraceMap.put(customTraceId, customTrace);
            result.success(customTraceId);
        } catch (RuntimeException e) {
            throw AGConnectAPMException.from(e);
        }
    }

    public void createNetworkMeasure(@NonNull MethodCall call, @NonNull Result result) throws AGConnectAPMException {
        try {
            final String url = Objects.requireNonNull(call.argument(KeyConstants.NETWORK_MEASURE_URL));
            final String method = Objects.requireNonNull(call.argument(KeyConstants.NETWORK_MEASURE_METHOD));

            final NetworkMeasure networkMeasure = APMS.getInstance().createNetworkMeasure(url, method);
            final String networkMeasureId = generateUniqueId(networkMeasureMap.keySet());
            networkMeasureMap.put(networkMeasureId, networkMeasure);
            result.success(networkMeasureId);
        } catch (RuntimeException e) {
            throw AGConnectAPMException.from(e);
        }
    }

    public void setUserIdentifier(@NonNull MethodCall call, @NonNull Result result) throws AGConnectAPMException {
        try {
            final String userIdentifier = Objects.requireNonNull(call.argument(KeyConstants.USER_IDENTIFIER));

            APMS.getInstance().setUserIdentifier(userIdentifier);
            result.success(true);
        } catch (RuntimeException e) {
            throw AGConnectAPMException.from(e);
        }
    }

    public void customTraceInner(@NonNull MethodCall call, @NonNull Result result) throws AGConnectAPMException {
        try {
            final String id = Objects.requireNonNull(call.argument(KeyConstants.ID));
            final String method = Objects.requireNonNull(call.argument(KeyConstants.METHOD));

            final CustomTrace customTrace = customTraceMap.get(id);
            switch (method) {
                case MethodConstants.CUSTOM_TRACE_START: {
                    customTrace.start();
                    result.success(true);
                    break;
                }
                case MethodConstants.CUSTOM_TRACE_STOP: {
                    customTrace.stop();
                    result.success(true);
                    break;
                }
                case MethodConstants.CUSTOM_TRACE_PUT_PROPERTY: {
                    final String propertyName = Objects.requireNonNull(call.argument(KeyConstants.PROPERTY_NAME));
                    final String propertyValue = Objects.requireNonNull(call.argument(KeyConstants.PROPERTY_VALUE));
                    customTrace.putProperty(propertyName, propertyValue);
                    result.success(true);
                    break;
                }
                case MethodConstants.CUSTOM_TRACE_REMOVE_PROPERTY: {
                    final String propertyName = Objects.requireNonNull(call.argument(KeyConstants.PROPERTY_NAME));
                    customTrace.removeProperty(propertyName);
                    result.success(true);
                    break;
                }
                case MethodConstants.CUSTOM_TRACE_GET_PROPERTY: {
                    final String propertyName = Objects.requireNonNull(call.argument(KeyConstants.PROPERTY_NAME));
                    final String propertyValue = customTrace.getProperty(propertyName);
                    result.success(propertyValue);
                    break;
                }
                case MethodConstants.CUSTOM_TRACE_GET_PROPERTIES: {
                    final Map<String, String> properties = customTrace.getTraceProperties();
                    result.success(properties);
                    break;
                }
                case MethodConstants.CUSTOM_TRACE_PUT_MEASURE: {
                    final String measureName = Objects.requireNonNull(call.argument(KeyConstants.MEASURE_NAME));
                    final int measureValue = Objects.requireNonNull(call.argument(KeyConstants.MEASURE_VALUE));
                    customTrace.putMeasure(measureName, measureValue);
                    result.success(true);
                    break;
                }
                case MethodConstants.CUSTOM_TRACE_GET_MEASURE: {
                    final String measureName = Objects.requireNonNull(call.argument(KeyConstants.MEASURE_NAME));
                    final long measureValue = customTrace.getMeasure(measureName);
                    result.success(measureValue);
                    break;
                }
                case MethodConstants.CUSTOM_TRACE_INCREMENT_MEASURE: {
                    final String measureName = Objects.requireNonNull(call.argument(KeyConstants.MEASURE_NAME));
                    final int measureValue = Objects.requireNonNull(call.argument(KeyConstants.MEASURE_VALUE));
                    customTrace.incrementMeasure(measureName, measureValue);
                    result.success(true);
                    break;
                }
                default: {
                    throw new AGConnectAPMException("MISSING_METHOD", "Custom trace inner method not found: " + method);
                }
            }
        } catch (RuntimeException e) {
            throw AGConnectAPMException.from(e);
        }
    }

    public void networkMeasureInner(@NonNull MethodCall call, @NonNull Result result) throws AGConnectAPMException {
        try {
            final String id = Objects.requireNonNull(call.argument(KeyConstants.ID));
            final String method = Objects.requireNonNull(call.argument(KeyConstants.METHOD));

            final NetworkMeasure networkMeasure = networkMeasureMap.get(id);
            switch (method) {
                case MethodConstants.NETWORK_MEASURE_START: {
                    networkMeasure.start();
                    result.success(true);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_STOP: {
                    networkMeasure.stop();
                    result.success(true);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_PUT_PROPERTY: {
                    final String propertyName = Objects.requireNonNull(call.argument(KeyConstants.PROPERTY_NAME));
                    final String propertyValue = Objects.requireNonNull(call.argument(KeyConstants.PROPERTY_VALUE));
                    networkMeasure.putProperty(propertyName, propertyValue);
                    result.success(true);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_REMOVE_PROPERTY: {
                    final String propertyName = Objects.requireNonNull(call.argument(KeyConstants.PROPERTY_NAME));
                    networkMeasure.removeProperty(propertyName);
                    result.success(true);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_GET_PROPERTY: {
                    final String propertyName = Objects.requireNonNull(call.argument(KeyConstants.PROPERTY_NAME));
                    final String propertyValue = networkMeasure.getProperty(propertyName);
                    result.success(propertyValue);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_GET_PROPERTIES: {
                    final Map<String, String> properties = networkMeasure.getProperties();
                    result.success(properties);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_SET_STATUS_CODE: {
                    final int statusCode = Objects.requireNonNull(call.argument(KeyConstants.STATUS_CODE));
                    networkMeasure.setStatusCode(statusCode);
                    result.success(true);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_SET_CONTENT_TYPE: {
                    final String contentType = Objects.requireNonNull(call.argument(KeyConstants.CONTENT_TYPE));
                    networkMeasure.setContentType(contentType);
                    result.success(true);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_SET_BYTES_SEND: {
                    final int bytesSend = Objects.requireNonNull(call.argument(KeyConstants.BYTES_SEND));
                    networkMeasure.setBytesSent(bytesSend);
                    result.success(true);
                    break;
                }
                case MethodConstants.NETWORK_MEASURE_SET_BYTES_RECEIVED: {
                    final int bytesReceived = Objects.requireNonNull(call.argument(KeyConstants.BYTES_RECEIVED));
                    networkMeasure.setBytesReceived(bytesReceived);
                    result.success(true);
                    break;
                }
                default: {
                    throw new AGConnectAPMException("MISSING_METHOD", "Network measure inner method not found: " + method);
                }
            }
        } catch (RuntimeException e) {
            throw AGConnectAPMException.from(e);
        }
    }

    // Helper Functions
    private String generateUniqueId(Set<String> ids) {
        while (true) {
            final int id = new SecureRandom().nextInt();
            if (!ids.contains(String.valueOf(id))) {
                return String.valueOf(id);
            }
        }
    }
}
