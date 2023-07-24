import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kemet/core/constants.dart';
import 'package:kemet/helper/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoints.baseUrl,
        receiveDataWhenStatusError: true,

        /// If you want to handle the headers HERE"
        // headers: {
        //   'Content-Type': 'application/json',
        //   'lang': 'ar',
        // },
      ),
    );
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      lang,
      token,
      onreceivProgres = null}) async {
    dio.options.headers["Authorization"] = 'Bearer ${AppConstants.token}';
    if (onreceivProgres == null) {
      onreceivProgres = (int a, int b) {};
    }
    return await dio.get(url,
        queryParameters: query, onReceiveProgress: onreceivProgres);
  }

  static Future<Response> postData({
    required url,
    query,
    required data,
    lang = 'en',
    token,
  }) async {
    if (token != null) {
      dio.options.headers["Authorization"] = 'Bearer $token';

      // dio.options.headers["Content-Type"] = 'application/json';
    }
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> postimage(
      {required url, query, required data, lang = 'en', token}) async {
    if (token != null) {
      dio.options.headers["Authorization"] = 'Bearer $token';
      dio.options.headers["Content-Type"] = "multipart/form-data";

      // dio.options.headers["Content-Type"] = 'application/json';
    }
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({required String url, required data}) async {
    return await dio.put(url, data: data);
  }

  static Future<Response> deleteData({required url, data}) async {
    return dio.delete(url, data: data);
  }
}
