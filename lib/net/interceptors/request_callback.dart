// 定义请求拦截处理函数
import 'package:dio/dio.dart';
import '../../utils/log_util.dart';
import '../../utils/sp_util.dart';


void onRequestInterceptor(RequestOptions options, RequestInterceptorHandler handler) {
  var token = SpUtil.read(SpUtil.TOKEN, '');
  if ('$token'.isNotEmpty) {
    options.headers['token'] = '$token';
  }

  var map = {
    'url': '${options.baseUrl}${options.path}',
    'headers': options.headers,
    'data': options.data,
  };
  Log.i(map);

  handler.next(options); // 使用handler.next传递请求
}