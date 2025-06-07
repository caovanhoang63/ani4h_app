import 'package:ani4h_app/core/data/remote/network_service_inteceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: "https://api.ani4h.site",
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );

  final dio = Dio(options);
  final networkServiceInterceptor =
  ref.watch(networkServiceInterceptorProvider(dio));

  dio.interceptors.addAll([
    HttpFormatter(
        loggingFilter: (request, response, error) => true,
    ),
    networkServiceInterceptor,
  ]);
  return dio;
});
