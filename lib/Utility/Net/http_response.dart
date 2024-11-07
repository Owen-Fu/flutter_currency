import 'package:flutter_currency/Utility/Net/base_server_resp.dart';

abstract class HttpResponse<T extends BaseServerResp> {
  final int? httpStatus;
  final dynamic json;
  final T? baseServerResp;

  HttpResponse(this.httpStatus, this.json, this.baseServerResp);
}

abstract class HttpResponseSuccess<T extends BaseServerResp> extends HttpResponse<T> {
  @override
  final T? baseServerResp;

  HttpResponseSuccess(int? httpStatus, dynamic data, this.baseServerResp) : super(httpStatus, data, baseServerResp);
}

class HttpResponseError<T extends BaseServerResp> extends HttpResponse<T> {
  final String? message;

  HttpResponseError(int? httpStatus, this.message, dynamic data) : super(httpStatus, data, null);
}

class ServerSuccess<T extends BaseServerResp> extends HttpResponseSuccess<T> {
  ServerSuccess(int? httpStatus, dynamic data, T? resp) : super(httpStatus, data, resp);
}

class ServerError<T> extends HttpResponseSuccess {
  final T data;

  ServerError.fromServer(int? httpStatus, this.data, BaseServerResp? baseServerResp)
      : super(httpStatus, data, baseServerResp);

  ServerError<M> copyTo<M>(M data) {
    return ServerError._(httpStatus, data, json, baseServerResp);
  }

  ServerError._(int? httpStatus, this.data, dynamic json, BaseServerResp? baseServerResp)
      : super(httpStatus, data, baseServerResp);
}
