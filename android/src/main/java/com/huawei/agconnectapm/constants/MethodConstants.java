/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
 */

package com.huawei.agconnectapm.constants;

public abstract class MethodConstants {
    public static final String ENABLE_COLLECTION = "ENABLE_COLLECTION";
    public static final String ENABLE_ANR_MONITOR = "ENABLE_ANR_MONITOR";
    public static final String CREATE_CUSTOM_TRACE = "CREATE_CUSTOM_TRACE";
    public static final String CREATE_NETWORK_MEASURE = "CREATE_NETWORK_MEASURE";
    public static final String SET_USER_IDENTIFIER = "SET_USER_IDENTIFIER";

    // Inner methods of custom trace object
    public static final String CUSTOM_TRACE_INNER = "CUSTOM_TRACE_INNER";
    public static final String CUSTOM_TRACE_START = "CUSTOM_TRACE_START";
    public static final String CUSTOM_TRACE_STOP = "CUSTOM_TRACE_STOP";
    public static final String CUSTOM_TRACE_PUT_PROPERTY = "CUSTOM_TRACE_PUT_PROPERTY";
    public static final String CUSTOM_TRACE_REMOVE_PROPERTY = "CUSTOM_TRACE_REMOVE_PROPERTY";
    public static final String CUSTOM_TRACE_GET_PROPERTY = "CUSTOM_TRACE_GET_PROPERTY";
    public static final String CUSTOM_TRACE_GET_PROPERTIES = "CUSTOM_TRACE_GET_PROPERTIES";
    public static final String CUSTOM_TRACE_PUT_MEASURE = "CUSTOM_TRACE_PUT_MEASURE";
    public static final String CUSTOM_TRACE_GET_MEASURE = "CUSTOM_TRACE_GET_MEASURE";
    public static final String CUSTOM_TRACE_INCREMENT_MEASURE = "CUSTOM_TRACE_INCREMENT_MEASURE";

    // Inner methods of network measure object
    public static final String NETWORK_MEASURE_INNER = "NETWORK_MEASURE_INNER";
    public static final String NETWORK_MEASURE_START = "NETWORK_MEASURE_START";
    public static final String NETWORK_MEASURE_STOP = "NETWORK_MEASURE_STOP";
    public static final String NETWORK_MEASURE_PUT_PROPERTY = "NETWORK_MEASURE_PUT_PROPERTY";
    public static final String NETWORK_MEASURE_REMOVE_PROPERTY = "NETWORK_MEASURE_REMOVE_PROPERTY";
    public static final String NETWORK_MEASURE_GET_PROPERTY = "NETWORK_MEASURE_GET_PROPERTY";
    public static final String NETWORK_MEASURE_GET_PROPERTIES = "NETWORK_MEASURE_GET_PROPERTIES";
    public static final String NETWORK_MEASURE_SET_STATUS_CODE = "NETWORK_MEASURE_SET_STATUS_CODE";
    public static final String NETWORK_MEASURE_SET_CONTENT_TYPE = "NETWORK_MEASURE_SET_CONTENT_TYPE";
    public static final String NETWORK_MEASURE_SET_BYTES_SEND = "NETWORK_MEASURE_SET_BYTES_SEND";
    public static final String NETWORK_MEASURE_SET_BYTES_RECEIVED = "NETWORK_MEASURE_SET_BYTES_RECEIVED";
}
