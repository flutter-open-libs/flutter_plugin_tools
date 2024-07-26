// 定义响应拦截处理函数
import 'package:dio/dio.dart';
import 'package:sing_plugin_tools/utils/log_util.dart';


void onResponseInterceptor(Response response, ResponseInterceptorHandler handler) {
  var request = response.requestOptions;
  var map = {
    'url': request.uri,
    'headers': request.headers,
    'parameters': request.queryParameters,
    'data': request.data,
    'response': response.data,
  };
  Log.i(map);

  handler.next(response); // 使用handler.next传递响应
}
