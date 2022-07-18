import 'package:dio/dio.dart';

class DioHelper {
  static Dio? _dio;

  static init() {
    _dio = Dio(BaseOptions(
        baseUrl: /*'https://newsapi.org/'*/ 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true));
  }

  static Future<Response?> getData({required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
     String? token}) async {
    _dio?.options.headers = { 'lang': lang,
      'Content-Type': 'application/json', 'Authorization': token};
    return await _dio?.get(url, queryParameters: query);
  }

  static Future<Response?> putData({required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token}) async {
    _dio?.options.headers = { 'lang': lang,
      'Content-Type': 'application/json', 'Authorization': token};
    return await _dio?.put(url, queryParameters: query);
  }

  static Future<Response?> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
  }) async {
    _dio?.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
    };

    return _dio?.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
