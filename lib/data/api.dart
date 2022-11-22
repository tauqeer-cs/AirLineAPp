import 'dart:io';

import 'package:app/app/app_flavor.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/repositories/cms_repository.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'dart:convert';

import '../app/app_logger.dart';
import '../models/error_response.dart';

/// A class to handle DIO API request
class Api {
  static final Api _instance = Api._internal();

  final Dio _dio = Dio(BaseOptions(
      connectTimeout: 10 * 1000, // 10 seconds
      receiveTimeout: 10 * 1000 // 10 seconds

      ));

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
        print("isSuccess $isSuccess isSuccessResult $isSuccessResult");
        if ((isSuccess is bool && !isSuccess) ||
            (isSuccessResult is bool && !isSuccessResult)) {
          print("inside error logic");
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
