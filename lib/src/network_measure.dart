// Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.

import 'package:flutter/services.dart';

import 'constants/channel_constants.dart';
import 'constants/key_constants.dart';
import 'constants/method_constants.dart';
import 'exceptions/exception.dart';

/// Network request indicator, which is used to monitor network request performance.
/// An instance needs to be created for each request or response.
class AGConnectAPMNetworkMeasure {
  final String _id;
  final MethodChannel _methodChannel = const MethodChannel(ChannelConstants.METHOD_CHANNEL);

  AGConnectAPMNetworkMeasure(this._id) : assert(_id.isNotEmpty);

  /// Sets the request start time.
  Future<void> start() async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_START,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Sets the request end time and reports network request indicators and custom attribute data.
  Future<void> stop() async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_STOP,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Sets the custom attribute name and value of a network request.
  /// Up to five custom attributes can be set for each AGConnectAPMNetworkMeasure instance.
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
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_PUT_PROPERTY,
          KeyConstants.PROPERTY_NAME: propertyName,
          KeyConstants.PROPERTY_VALUE: propertyValue,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Removes an existing attribute from a AGConnectAPMNetworkMeasure instance.
  ///
  /// **propertyName**
  ///   * Name of the attribute to be removed.
  Future<void> removeProperty(String propertyName) async {
    assert(propertyName.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_REMOVE_PROPERTY,
          KeyConstants.PROPERTY_NAME: propertyName,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Obtains a custom attribute value.
  ///
  /// **propertyName**
  ///   * Custom attribute name.
  Future<String?> getProperty(String propertyName) async {
    assert(propertyName.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<String?>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_GET_PROPERTY,
          KeyConstants.PROPERTY_NAME: propertyName,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Obtains all attributes from a AGConnectAPMNetworkMeasure instance.
  Future<Map<String, String>> getProperties() async {
    try {
      final Map<dynamic, dynamic>? properties = await _methodChannel.invokeMethod<Map<dynamic, dynamic>>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_GET_PROPERTIES,
        },
      );
      return Map<String, String>.from(properties ?? const <String, String>{});
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Sets the response code of a request.
  ///
  /// **statusCode**
  ///   * Response code of a request.
  Future<void> setStatusCode(int statusCode) async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_SET_STATUS_CODE,
          KeyConstants.STATUS_CODE: statusCode,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Sets the response body type specified by contentType.
  ///
  /// **contentType**
  ///   * Response body type specified by contentType.
  Future<void> setContentType(String contentType) async {
    assert(contentType.isNotEmpty);

    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_SET_CONTENT_TYPE,
          KeyConstants.CONTENT_TYPE: contentType,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Sets the request body size.
  ///
  /// **bytesSend**
  ///   * Request body size.
  Future<void> setBytesSend(int bytesSend) async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_SET_BYTES_SEND,
          KeyConstants.BYTES_SEND: bytesSend,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }

  /// Sets the response body size.
  ///
  /// **bytesReceived**
  ///   * Response body size.
  Future<void> setBytesReceived(int bytesReceived) async {
    try {
      return await _methodChannel.invokeMethod<void>(
        MethodConstants.NETWORK_MEASURE_INNER,
        <String, dynamic>{
          KeyConstants.ID: _id,
          KeyConstants.METHOD: MethodConstants.NETWORK_MEASURE_SET_BYTES_RECEIVED,
          KeyConstants.BYTES_RECEIVED: bytesReceived,
        },
      );
    } catch (e) {
      throw AGConnectAPMException.from(e);
    }
  }
}
