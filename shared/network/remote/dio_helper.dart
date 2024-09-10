import 'package:dio/dio.dart';

class dio_helper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required final String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio.get(
      url,
      queryParameters: query??null,
    );
  }

  static Future<Response> postData({
    required final String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token??'',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
