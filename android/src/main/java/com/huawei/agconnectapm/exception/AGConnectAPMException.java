/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
 */

package com.huawei.agconnectapm.exception;

import com.huawei.agconnect.apms.exception.APMSException;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import io.flutter.Log;

public class AGConnectAPMException extends Exception {
    private final String errorCode;
    private final String errorMessage;
    private final Map<String, Object> errorDetails = new HashMap<>();

    public static AGConnectAPMException from(Exception e) {
        if (e instanceof AGConnectAPMException) {
            return (AGConnectAPMException) e;
        } else {
            if (e instanceof APMSException) {
                return new AGConnectAPMException("UNKNOWN", e.getMessage(), "SDKException");
            } else {
                return new AGConnectAPMException("UNKNOWN", e.getMessage());
            }
        }
    }

    public AGConnectAPMException(String code, String message) {
        this(code, message, "PluginException");
    }

    private AGConnectAPMException(String code, String message, String exceptionType) {
        this.errorCode = code;
        this.errorMessage = message;
        this.errorDetails.put("exceptionType", exceptionType);

        Log.e("AGConnectAPMPlugin", String.format(Locale.ENGLISH, "(%s) %s: %s", exceptionType, this.errorCode, this.errorMessage));
    }

    public String getErrorCode() {
        return this.errorCode;
    }

    public String getErrorMessage() {
        return this.errorMessage;
    }

    public Map<String, Object> getErrorDetails() {
        return this.errorDetails;
    }
}
