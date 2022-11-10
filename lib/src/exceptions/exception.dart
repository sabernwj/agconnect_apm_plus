// Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.

import 'package:flutter/services.dart';

class AGConnectAPMException implements Exception {
  final String code;
  final String message;

  const AGConnectAPMException._internal({
    required this.code,
    required this.message,
  });

  factory AGConnectAPMException.from(dynamic e) {
    if (e is AGConnectAPMException) {
      return e;
    } else {
      if (e is PlatformException) {
        return AGConnectAPMException._internal(
          code: e.code,
          message: e.message ?? 'Something went wrong.',
        );
      } else {
        return AGConnectAPMException._internal(
          code: 'UNKNOWN',
          message: e is String ? e : 'Something went wrong.',
        );
      }
    }
  }

  @override
  String toString() {
    return 'AGConnectAPMException(code: $code message: $message)';
  }
}
