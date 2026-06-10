import 'package:dio/dio.dart';

class DioHelper {
  DioHelper._();

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    ),
  );

  static void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  static void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    return _responseHandler(response);
  }

  static Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return _responseHandler(response);
  }

  static Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return _responseHandler(response);
  }

  static Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return _responseHandler(response);
  }

  static dynamic _responseHandler(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Bad request: ${response.data}',
        );
      case 401:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Unauthorized: check your credentials or token.',
        );
      case 403:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Forbidden: you do not have access to this resource.',
        );
      case 404:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Not found: ${response.requestOptions.path}',
        );
      case 500:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Internal server error.',
        );
      default:
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Unexpected status code: ${response.statusCode}',
        );
    }
  }
}
