// Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.

import 'package:flutter/services.dart';

import 'constants/channel_constants.dart';
import 'constants/key_constants.dart';
import 'constants/method_constants.dart';
import 'exceptions/exception.dart';

/// Custom trace used to monitor the performance of an app in a specific scenario.
/// For example, user sign-in.
class AGConnectAPMCustomTrace {
  final String _id;
  final MethodChannel _methodChannel = const MethodChannel(ChannelConstants.METHOD_CHANNEL);

  AGConnectAPMCustomTrace(this._id) : assert(_id.isNotEmpty);

  /// Starts a custom trace.
  Future<void> start() async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_START,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Stops a custom trace
  Future<void> stop() async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_STOP,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Sets the attribute names and values of a custom trace.
  /// Up to five custom attributes can be set for each AGConnectAPMCustomTrace instance.
  ///
  /// **propertyName**
  ///   * Name of a custom attribute.
  ///   * The name can contain only Chinese characters, letters (case-insensitive),
  ///     digits, and underscores (_), with up to 40 characters.
  ///
  /// **propertyValue**
  ///   * Value of a custom attribute.
  ///   * The value can contain only Chinese characters, letters (case-insensitive),
  ///     digits, and underscores (_), with up to 100 characters.
  Future<void> putProperty(String propertyName, String propertyValue) async {
    assert(propertyName.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_PUT_PROPERTY,
          KeyConstants.PROPERTY_NAME: propertyName,
          KeyConstants.PROPERTY_VALUE: propertyValue,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Removes an existing attribute from a AGConnectAPMCustomTrace instance.
  ///
  /// **propertyName**
  ///   * Name of the attribute to be removed.
  Future<void> removeProperty(String propertyName) async {
    assert(propertyName.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_REMOVE_PROPERTY,
          KeyConstants.PROPERTY_NAME: propertyName,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Obtains a custom attribute value.
  Future<String?> getProperty(String propertyName) async {
    assert(propertyName.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<String?>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_GET_PROPERTY,
          KeyConstants.PROPERTY_NAME: propertyName,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Obtains all attributes of a custom trace.
  Future<Map<String, String>> getProperties() async {
    try {
      final Map<dynamic, dynamic>? properties = await _methodChannel.invokeMethod<Map<dynamic, dynamic>>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_GET_PROPERTIES,
        },
      );
      return Map<String, String>.from(properties ?? const <String, String>{});
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Adds an indicator for a custom trace.
  /// If the indicator already exists, the value of the indicator is updated.
  ///
  /// **measureName**
  ///   * Indicator name of a custom trace.
  ///
  /// **measureValue**
  ///   * Indicator value of a custom trace.
  Future<void> putMeasure(String measureName, int measureValue) async {
    assert(measureName.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_PUT_MEASURE,
          KeyConstants.MEASURE_NAME: measureName,
          KeyConstants.MEASURE_VALUE: measureValue,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Obtains an indicator value for a custom trace.
  ///
  /// **measureName**
  ///   * Name of a custom trace indicator.
  Future<int?> getMeasure(String measureName) async {
    assert(measureName.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<int?>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_GET_MEASURE,
          KeyConstants.MEASURE_NAME: measureName,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Adds an indicator value for a custom trace.
  /// If the indicator does not exist, a new one is created.
  /// If the custom trace is not started or has been stopped, the API does not take effect.
  ///
  /// **measureName**
  ///   * Name of the custom trace indicator to which an indicator value is to be added.
  ///
  /// **measureValue**
  ///   * Indicator value to be added.
  Future<void> incrementMeasure(String measureName, int measureValue) async {
    assert(measureName.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.CUSTOM_TRACE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.CUSTOM_TRACE_INCREMENT_MEASURE,
          KeyConstants.MEASURE_NAME: measureName,
          KeyConstants.MEASURE_VALUE: measureValue,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }
}
