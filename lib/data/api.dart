import 'dart:io';
import 'package:app/app/app_flavor.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/repositories/cms_repository.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:firebase_performance/firebase_performance.dart';
import '../app/app_logger.dart';
import '../models/error_response.dart';

/// A class to handle DIO API request
class Api {
  static final Api _instance = Api._internal();

  final Dio _dio = Dio(BaseOptions(
      connectTimeout: 15 * 1000, // 10 seconds
      receiveTimeout: 15 * 1000 // 10 seconds

      ));

  Api._internal() {
    logger.i("Initializing API client...");
    _dio.interceptors.add(DioFirebasePerformanceInterceptor());
    _dio.interceptors.add(MyInterceptor());
    if (_dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  static Dio get client => _instance._dio;
}

/// Interceptor to print requests, responses, and errors
class MyInterceptor extends Interceptor {
  final _cmsRepository = CMSRepository();

  ///to format data response
  final JsonEncoder _encoder = const JsonEncoder.withIndent(' ');

  _log(String url, [dynamic data]) {
    if (data is Map) {
      String prettyPrint = _encoder.convert(data);
      developer.log(
        url,
        name: "resit.api",
        error: prettyPrint,
      );
    }
  }

  final _repository = AuthenticationRepository();

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.queryParameters.isNotEmpty) {
      final queryParameters = options.queryParameters.map((key, value) {
        if (value is! Iterable) {
          value = value.toString();
        }
        return MapEntry(key, value);
      });
      final uri = Uri(path: options.path, queryParameters: queryParameters);
      options.path = uri.toString();
      options.queryParameters = {};
    }

    if (options.method != 'GET') {
      if (options.data is Map) {
        _log(
          "=> ${options.method} ${options.uri.toString()}",
          options.data,
        );
      }
      if (options.data is List) {
        final reqData = options.data as List;
        _log(
          "=> ${options.method} ${options.uri.toString()}",
          reqData.first,
        );
      }
    } else {
      logger.e(
        "=> ${options.method} ${options.uri.toString()}",
      );
      if (options.data is Map) {
        _log(
          "=> ${options.method} ${options.uri.toString()}",
          options.data,
        );
      }
    }

    ///used if API request is using access token
    ///

    String? accessTokenData = await _repository.getAccessToken();

    String? accessToken = options.baseUrl.contains(AppFlavor.paymentRedirectUrl)
        ? _cmsRepository.cmsToken
        : accessTokenData;
    if (accessToken != null) {
      options.headers['Authorization'] = "Bearer $accessToken";
    }
    super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(response.data);
    if (response.data is Map) {
      Map result = response.data;
      if (result.containsKey("result")) {
        final data = result["result"];
        final isSuccess = result["success"] ?? true;
        final isSuccessResult = data["success"] ?? true;
        if (data is Map && data.containsKey("value")) {
          final dataValue = result["result"]["value"];
          final isSuccessValue = dataValue["success"] ?? true;
          if (isSuccessValue is bool && !isSuccessValue) {
            if (dataValue["error"] != null && dataValue["error"] is Map) {
              throw ErrorResponse.fromJson(dataValue["error"]);
            }
          }
        }
        if ((isSuccess is bool && !isSuccess) ||
            (isSuccessResult is bool && !isSuccessResult)) {
          if (result["error"] != null && result["error"] is Map) {
            throw ErrorResponse.fromJson(result["error"]);
          } else if (data["error"] != null && data["error"] is Map) {
            throw ErrorResponse.fromJson(data["error"]);
          } else if (data["message"] != null) {
            throw ErrorResponse(data["message"]);
          } else if (data["errorMessage"] != null) {
            throw ErrorResponse(data["errorMessage"]);
          }
        }
        response.data = result["result"];
        // _log(
        //   "<= ${response.requestOptions.method} ${response.requestOptions.baseUrl} ${response.realUri.toString()}",
        //   response.data,
        // );
        Map resultData = response.data;
        if (resultData.containsKey("data")) {
          response.data = resultData["data"];
        }
      }
    }

    super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    var error = err.error;
    logger.e(err);
    if (err.type == DioErrorType.connectTimeout || err.type == DioErrorType.receiveTimeout) {
      Map<String, dynamic> errors = {
        'message': "Connection timed out"
      };
      //_repository.deleteCurrentUser();
      throw ErrorResponse.fromJson(errors);
    }
    if (err.response?.statusCode == 401) {
      logger.e('Error is Unauthorized');
      Map<String, dynamic> errors = {
        'message': "Your token is invalid, please login again"
      };
      //_repository.deleteCurrentUser();
      throw ErrorResponse.fromJson(errors);
    } else if (err.response?.data is Map) {
      Map<String, dynamic> data = err.response!.data;
      logger.e('Error is map $data');
      if (data.containsKey("message")) {
        throw ErrorResponse.fromJson(data);
      }
      if (data.containsKey("title")) {
        Map<String, dynamic> errors = {'message': data['title']};

        throw ErrorResponse.fromJson(errors);
      }
    } else if (error is SocketException) {
      logger.e('SocketException');
      Map<String, dynamic> errors = {'message': 'No internet connection'};
      throw ErrorResponse.fromJson(errors);
    } else if (error is String) {
      logger.e('Error is String $error');
      Map<String, dynamic> errors = {'message': error};
      throw ErrorResponse.fromJson(errors);
    } else if (error is ErrorResponse) {
      throw error;
    } else {}
    super.onError(error, handler);
  }
}


/// [Dio] client interceptor that hooks into request/response process
/// and calls Firebase Metric API in between. The request key is calculated
/// based upon [extra] field hash code which appears to be the same across
/// [onRequest], [onResponse] and [onError] calls.
///
/// Additionally there is no good API of obtaining content length from interceptor
/// API so we're "approximating" the byte length based on headers & request data.
/// If you're not fine with this, you can provide your own implementation in the constructor
///
/// This interceptor might be counting parsing time into elapsed API call duration.
/// I am not fully aware of [Dio] internal architecture.
class DioFirebasePerformanceInterceptor extends Interceptor {
  DioFirebasePerformanceInterceptor({
    this.requestContentLengthMethod = defaultRequestContentLength,
    this.responseContentLengthMethod = defaultResponseContentLength,
  });

  /// key: requestKey hash code, value: ongoing metric
  final _map = <int, HttpMetric>{};
  final RequestContentLengthMethod requestContentLengthMethod;
  final ResponseContentLengthMethod responseContentLengthMethod;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final metric = FirebasePerformance.instance.newHttpMetric(
        options.uri.normalized(),
        options.method.asHttpMethod()!,
      );

      final requestKey = options.extra.hashCode;
      _map[requestKey] = metric;
      final requestContentLength = requestContentLengthMethod(options);
      await metric.start();
      if (requestContentLength != null) {
        metric.requestPayloadSize = requestContentLength;
      }
    } catch (_) {}
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    try {
      final requestKey = response.requestOptions.extra.hashCode;
      final metric = _map[requestKey];
      metric?.setResponse(response, responseContentLengthMethod);
      await metric?.stop();
      _map.remove(requestKey);
    } catch (_) {}
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      final requestKey = err.requestOptions.extra.hashCode;
      final metric = _map[requestKey];
      metric?.setResponse(err.response, responseContentLengthMethod);
      await metric?.stop();
      _map.remove(requestKey);
    } catch (_) {}
    return super.onError(err, handler);
  }
}

typedef RequestContentLengthMethod = int? Function(RequestOptions options);
int? defaultRequestContentLength(RequestOptions options) {
  try {
    return options.headers.toString().length + options.data.toString().length;
  } catch (_) {
    return null;
  }
}

typedef ResponseContentLengthMethod = int? Function(Response options);
int? defaultResponseContentLength(Response response) {
  try {
    String? lengthHeader = response.headers[Headers.contentLengthHeader]?.first;
    int length = int.parse(lengthHeader ?? '-1');
    if (length <= 0) {
      int headers = response.headers.toString().length;
      length = headers + response.data.toString().length;
    }
    return length;
  } catch (_) {
    return null;
  }
}

extension _ResponseHttpMetric on HttpMetric {
  void setResponse(Response? value,
      ResponseContentLengthMethod responseContentLengthMethod) {
    if (value == null) {
      return;
    }
    final responseContentLength = responseContentLengthMethod(value);
    if (responseContentLength != null) {
      responsePayloadSize = responseContentLength;
    }
    final contentType = value.headers.value.call(Headers.contentTypeHeader);
    if (contentType != null) {
      responseContentType = contentType;
    }
    if (value.statusCode != null) {
      httpResponseCode = value.statusCode;
    }
  }
}

extension _UriHttpMethod on Uri {
  String normalized() {
    return "$scheme://$host$path";
  }
}

extension _StringHttpMethod on String {
  HttpMethod? asHttpMethod() {
    switch (toUpperCase()) {
      case 'POST':
        return HttpMethod.Post;
      case 'GET':
        return HttpMethod.Get;
      case 'DELETE':
        return HttpMethod.Delete;
      case 'PUT':
        return HttpMethod.Put;
      case 'PATCH':
        return HttpMethod.Patch;
      case 'OPTIONS':
        return HttpMethod.Options;
      default:
        return null;
    }
  }
}
