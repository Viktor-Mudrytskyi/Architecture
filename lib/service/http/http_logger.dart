import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../logger/logger.dart';

class DioLogger extends Interceptor {
  final Logger logger = Logger();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kDebugMode) {
      return;
    }
    logger.logError(
      '${err.requestOptions.method} ${err.response?.statusCode} ${err.requestOptions.uri}\n$err',
    );
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) {
      return;
    }
    logger.logInfo(
      '${options.method} ${options.uri}\n-----Headers------\n${_formatIfJson(options.headers)}\n------Request-Body-----\n${_formatIfJson(options.data)}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (!kDebugMode) {
      return;
    }
    logger.logSuccess(
      '${response.requestOptions.method} ${response.statusCode} ${response.requestOptions.uri}\n------Headers-----\n${_formatIfJson(response.headers)}\n-----Response-Body------\n${_formatIfJson(response)}',
    );
    super.onResponse(response, handler);
  }

  String _formatIfJson(Object? data) {
    try {
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      if (data is Map) {
        return encoder.convert(data);
      }
      final map = jsonDecode(data.toString());
      return encoder.convert(map);
    } catch (e) {
      return data.toString();
    }
  }
}
