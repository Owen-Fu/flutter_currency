import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_currency/Utility/Net/base_server_resp.dart';
import 'package:flutter_currency/Utility/Net/http_response.dart';

typedef RespParser = BaseServerResp? Function(Type t, Response data);

class Requester {
  static late final Requester _ins;

  static Requester get ins => _ins;

  final Dio _dio = Dio();

  Requester({bool isShowLog = false}) {
    _ins = this;
    if (isShowLog) _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, error: true));
  }

  RespParser? respParser;

  /// 通用的GET请求
  Future<T?> get<T extends BaseServerResp>(String api, {Map<String, dynamic>? parameters}) async {
    parameters?.removeWhere((key, value) => value == null || value == '');
    Dio dio = _dio;
    return _start<T>(dio.get(api, queryParameters: parameters)).then((value) => value.baseServerResp);
  }

  /// 開始請求 http
  Future<HttpResponse<T>> _start<T extends BaseServerResp>(Future<Response> dioTask,
      {bool hasAPIErrorHandel = false}) async {
    try {
      Response response = await dioTask;
      int? httpStatus = response.statusCode;
      if (httpStatus == HttpStatus.noContent) {
        return ServerSuccess(httpStatus, response.data, null);
      } else {
        if (response.data is List<dynamic>) response.data = {"data": response.data};

        /// 內容不是 map => error
        if (response.data is String) throw ServerError.fromServer(httpStatus, response.data, null);
        final resp = respParser?.call(T, response)?..httpStatus = httpStatus;
        assert(resp != null);
        return ServerSuccess(httpStatus, response.data, resp as T);
      }
    } on DioException catch (e) {
      throw ServerError.fromServer(e.response?.statusCode, e.response?.data, null);
    } catch (e) {
      rethrow;
    }
  }
}
