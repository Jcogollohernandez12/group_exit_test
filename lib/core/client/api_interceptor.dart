import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.connectTimeout = const Duration(seconds: 180);
    options.receiveTimeout = const Duration(seconds: 180);

    options.headers.addEntries(<MapEntry<String, String>>[const MapEntry<String, String>('Authorization', 'Bearer ')]);
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
  }

  @override
  Future<void> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
  }
}
