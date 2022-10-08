import 'dart:io';

import 'package:app/data/repositories/cms_repository.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'dart:convert';

import '../app/app_flavor.dart';
import '../app/app_logger.dart';
import '../models/error_response.dart';

/// A class to handle DIO API request
class Api {
  static final Api _instance = Api._internal();
  final Dio _dio = Dio();

  Api._internal() {
    logger.i("Initializing API client...");
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
    String? accessToken = options.baseUrl.contains("mya-cms.alphareds.com")
        ? _cmsRepository.cmsToken
        : null;
    if (accessToken != null) {
      options.headers['Authorization'] = "Bearer $accessToken";
    }
    print("headers ${options.headers['Authorization']}");
    super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(response.data);
    if (response.data is Map) {
      Map result = response.data;
      if (result.containsKey("result")) {
        final isSuccess = result["success"] ?? true;
        if (isSuccess is bool && !isSuccess) {
          if(result["error"] !=null && result["error"] is Map){
            throw ErrorResponse.fromJson(result["error"]);
            return;
          }
        }
        response.data = result["result"];
        _log(
          "<= ${response.requestOptions.method} ${response.requestOptions.baseUrl} ${response.realUri.toString()}",
          response.data,
        );
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
    if (err.response?.statusCode == 401) {
      logger.e('Error is Unauthorized');
      Map<String, dynamic> errors = {
        'message': "Your token is invalid, please login again"
      };
      //_repository.deleteCurrentUser();
      throw ErrorResponse.fromJson(errors);
    } else if (err.response?.data is Map) {
      Map<String, dynamic> data = err.response!.data;
      logger.e(data);
      if (data.containsKey("message")) {
        throw ErrorResponse.fromJson(data);
      }
    } else if (error is SocketException) {
      logger.e('SocketException');
      Map<String, dynamic> errors = {'message': 'No internet connection'};
      throw ErrorResponse.fromJson(errors);
    } else if (error is String) {
      logger.e('Error is String $error');
      Map<String, dynamic> errors = {'message': error};
      throw ErrorResponse.fromJson(errors);
    }
    super.onError(error, handler);
  }
}
