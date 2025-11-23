import 'dart:developer';

import 'package:dalil_2020_app/core/errors/failure.dart';
import 'package:dio/dio.dart';

import 'cache/cache_helper.dart';
import 'package:logger/logger.dart';

import 'end_points.dart';

class DioHelper {
  static final _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    receiveDataWhenStatusError: true,
  ));

  static interceptors() {
    _dio.interceptors.add(CustomApiInterceptor());
  }

  static Map<String, dynamic> get _constHeader => {
        if (CachHelper.isAuth) 'Authorization': "bearer ${CachHelper.token}",
        "Accept": "application/json"
      };
  static Future<CustomResponse> send(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final respone = await _dio.post(
        path,
        data: FormData.fromMap(data ?? {}),
        options: Options(headers: _constHeader),
      );
      print('respone:${respone.realUri}');
      log('respone:${respone.realUri}');
      return CustomResponse(
          isSuccess: true, data: respone.data, statusCode: respone.statusCode);
    } on DioException catch (ex) {
      print(ex.response?.data);
      print(ex.error);
      return CustomResponse(
          isSuccess: false,
          statusCode: ex.response?.statusCode,
          data: ex.response?.data,
          msg: ex.error.toString());
    }
  }

  static Future<CustomResponse> put(String path,
      {Map<String, dynamic>? data, FormData? formData}) async {
    print("bearer ${CachHelper.token}");
    try {
      final response = await _dio.put(
        path,
        data: data ?? formData,
        options: Options(headers: _constHeader),
      );
      return CustomResponse(
        isSuccess: true,
        data: data,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      return CustomResponse(
          isSuccess: false,
          statusCode: e.response!.statusCode,
          data: e.response!.data,
          msg: e.response!.data['message']);
    }
  }

  static Future<CustomResponse> delete(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(path,
          data: data, options: Options(headers: _constHeader));
      return CustomResponse(
          isSuccess: true, data: data, statusCode: response.statusCode);
    } on DioException catch (e) {
      return CustomResponse(
          isSuccess: false,
          msg: e.response!.data['message'],
          statusCode: e.response!.statusCode,
          data: e.response!.data);
    }
  }

  static Future<CustomResponse> get(String path,
      {Map<String, dynamic>? parameter}) async {
    try {
      final respone = await _dio.get(path,
          queryParameters: parameter, options: Options(headers: _constHeader));
      print('respone:${respone.realUri}');
      return CustomResponse(
          isSuccess: true, data: respone.data, statusCode: respone.statusCode);
    } on DioException catch (ex) {
      print("-=-=-=-=-=-=-=-=-=-=-= ${ex.response?.statusCode}");
      return CustomResponse(
          isSuccess: false,
          data: ex.response?.data,
          statusCode: ex.response?.statusCode,
          msg: ex.response!.data['message']);
    }
  }
}

class CustomResponse {
  final String msg;
  final data;
  final bool isSuccess;
  final int? statusCode;
  final Failure? error;
  CustomResponse(
      {this.msg = "",
      this.data,
      required this.isSuccess,
      this.statusCode,
      this.error});
}

class CustomApiInterceptor extends Interceptor {
  final logger = Logger();
  CustomApiInterceptor();
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
        "------ Current Error Response (status code ${err.response?.statusCode}) -----");
    logger.e("${err.response?.data}");
    if (err.response != null) {
      logger.e("Response Data: ${err.response?.data}");
    }
    return super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    logger.d(
        "------ Current Response (status code ${response.statusCode}) ------");
    logger.d(response.data);
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.w("------ Current Request Path -----");
    logger.w("${options.path} API METHOD : (${options.method})");
    if (options.data != null) {
      logger.w("------ Current Request body Data -----");
      if (options.data is FormData) {
        Map<String, dynamic> body = {};
        options.data.fields.forEach((element) {
          body[element.key] = '${element.value}';
        });
        logger.w(body);
      } else {
        logger.w(options.data);
      }
    }
    logger.w("------ Current Request Parameters Data -----");
    logger.w("${options.queryParameters}");
    logger.w("------ Current Request Headers -----");
    logger.w("${options.headers}");
    return super.onRequest(options, handler);
  }
}
