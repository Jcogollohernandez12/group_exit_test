import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:group_exito/core/client/api_interceptor.dart';
import 'package:group_exito/core/config/envs/environments.dart';

// ignore: prefer_mixin
class ApiClient with DioMixin implements Dio {
  ApiClient() {
    options = BaseOptions();
    httpClientAdapter = IOHttpClientAdapter();
    interceptors.add(ApiInterceptor());
    options.baseUrl = Environment().config.baseUrl;
  }
}
