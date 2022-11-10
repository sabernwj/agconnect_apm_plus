// Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'constants/channel_constants.dart';
import 'constants/key_constants.dart';
import 'constants/method_constants.dart';
import 'custom_trace.dart';
import 'enums/network_measure_methods.dart';
import 'exceptions/exception.dart';
import 'network_measure.dart';

class AGConnectAPM {
  static AGConnectAPM? _instance;
  static AGConnectAPM getInstance() {
    if (_instance == null) {
      _instance = AGConnectAPM._internal();
    }
    return _instance!;
  }

  const AGConnectAPM._internal();

  final MethodChannel _methodChannel = const MethodChannel(ChannelConstants.METHOD_CHANNEL);

  /// Sets whether to enable the APM.
  /// The default value is true, indicating that APM app performance data collection is enabled.
  /// To disable app performance data collection of APM, set this parameter to false.
  ///
  /// **enable**
  ///   * Sets whether to enable APM to collect performance monitoring data.
  Future<void> enableCollection([bool enable = true]) async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.ENABLE_COLLECTION,
        <String, dynamic>{
          KeyConstants.ENABLE: enable,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Sets whether to enable the ANR monitoring.
  /// The default value is true, indicating that ANR monitoring is enabled, and data is reported.
  /// To disable ANR monitoring, set this parameter to false.
  ///
  /// **ANR monitoring takes effect only when the APM service is enabled.**
  ///
  /// **enable**
  ///   * Indicates whether to enable the ANR monitoring function.
  Future<void> enableAnrMonitor([bool enable = true]) async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.ENABLE_ANR_MONITOR,
        <String, dynamic>{
          KeyConstants.ENABLE: enable,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Creates a custom trace for a specific scenario in an app based on the input parameter traceName.
  ///
  /// **traceName**
  ///   * Name of a custom trace.
  ///   * The name can contain only Chinese characters, letters (case-insensitive),
  ///     digits, and underscores (_), with up to 100 characters.
  Future<AGConnectAPMCustomTrace> createCustomTrace(String traceName) async {
    assert(traceName.isNotEmpty);

    try {
      final String? customTraceId = await _methodChannel.invokeMethod<String>(
        MethodConstants.CREATE_CUSTOM_TRACE,
        <String, dynamic>{
          KeyConstants.CUSTOM_TRACE_NAME: traceName,
        },
      );
      return AGConnectAPMCustomTrace(customTraceId!);
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Creates a network request indicator instance for each network request to collect network performance data.
  ///
  /// **url**
  ///   * Network request URL.
  ///
  /// **method**
  ///   * Request method.
  ///   * Only the GET, PUT, POST, DELETE, HEAD, PATCH, OPTIONS, TRACE, and CONNECT methods are supported.
  Future<AGConnectAPMNetworkMeasure> createNetworkMeasure({
    required String url,
    required AGConnectAPMNetworkMeasureMethods method,
  }) async {
    assert(url.isNotEmpty);

    try {
      final String? networkMeasureId = await _methodChannel.invokeMethod<String>(
        MethodConstants.CREATE_NETWORK_MEASURE,
        <String, dynamic>{
          KeyConstants.NETWORK_MEASURE_URL: url,
          KeyConstants.NETWORK_MEASURE_METHOD: describeEnum(method),
        },
      );
      return AGConnectAPMNetworkMeasure(networkMeasureId!);
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Binds a user ID to the reported data.
  /// When the performance data is reported, the user ID is also reported to facilitate fault locating.
  ///
  /// **userIdentifier**
  ///   * User ID. You need to ensure its privacy compliance.
  Future<void> setUserIdentifier(String userIdentifier) async {
    assert(userIdentifier.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.SET_USER_IDENTIFIER,
        <String, dynamic>{
          KeyConstants.USER_IDENTIFIER: userIdentifier,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  Future<T> addCustomTrace<T>({
    bool enabled = true,
    required String traceName,
    required FutureOr<T> Function() function,
  }) async {
    if (enabled) {
      final AGConnectAPMCustomTrace trace = await createCustomTrace(traceName);
      await trace.start();
      try {
        final T functionResult = await function.call();
        return functionResult;
      } catch (e) {
        rethrow;
      } finally {
        await trace.stop();
      }
    } else {
      final T functionResult = await function.call();
      return functionResult;
    }
  }
}
