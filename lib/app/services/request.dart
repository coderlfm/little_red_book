import 'package:dio/dio.dart';
import './config.dart';

class Request {
  static final dio = Dio(BaseOptions(
      baseUrl: Config.baseUrl, connectTimeout: Config.timeout, method: Config.method, headers: Config.headers));

  static Future<T> request<T>(String url,
      {Map<String, dynamic>? queryParameters, String? method, Map<String, dynamic>? headers}) async {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handle) {
      print('请求拦截: ${options.uri} ${options.data}');
      return handle.next(options);
    }, onResponse: (options, handle) {
      print('响应拦截');
      return handle.next(options);
    }, onError: (options, handle) {
      print('错误拦截 ${options.response}');
      return handle.next(options);
    }));

    Options options = Options(method: method, headers: headers);
    final res = await dio.request(url, queryParameters: queryParameters, options: options);
    return res.data;
  }
}
