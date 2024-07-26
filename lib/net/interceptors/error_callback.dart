import 'package:dio/dio.dart';

void onErrorInterceptor(DioException e, ErrorInterceptorHandler handler) {
  handler.next(e); // 使用handler.next传递错误
}