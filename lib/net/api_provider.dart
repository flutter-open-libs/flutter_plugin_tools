import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:sing_plugin_tools/export.dart';

import 'api_response.dart';
import 'interceptors/error_callback.dart';
import 'interceptors/request_callback.dart';
import 'interceptors/response_callback.dart';

class ApiProvider {

  static String _baseUrl = '';
  static init(String baseUrl){
    _baseUrl = baseUrl;
  }

  Dio? _dio;
  Dio getDio(){
    if(_dio == null){
      _dio = Dio();

      _dio!.options.baseUrl = _baseUrl;
      _dio!.options.connectTimeout = Duration(seconds: 5);
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: onRequestInterceptor,
        onResponse: onResponseInterceptor,
        onError: onErrorInterceptor,
      ));

      var isOpenProxy = SpUtil.read(SpUtil.IS_OPEN_PROXY,false);
      var host = SpUtil.read(SpUtil.PROXY_HOST,'');
      var port = SpUtil.read(SpUtil.PROXY_PORT,'');
      if(isOpenProxy && '$host'.isNotEmpty && '$port'.isNotEmpty){
        _dio!.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          client.findProxy = (uri) => 'PROXY $host:$port';
          return client;
        });
      }
    }
    return _dio!;
  }

  Future<ApiResponse> getData(Map<String, dynamic> map,String url,{bool isNeedToast = true}) async {
    String jsonString = json.encode(map);
    var netParams = SpUtil.read(SpUtil.NET_PARAMS,'');

    try {
      final response = await getDio().post('$url$netParams', data: jsonString);
      var result = ApiResponse.fromJson(response.data);

      if (result.code == 405 || result.code == 406) {
        EasyLoading.showToast('${result.msg}');
        EventBusUtil.singleton.send('token_error');
      } else {
        if (isNeedToast && result.code != 200) {
          EasyLoading.showToast('${result.msg}');
        }
      }
      return result;
    } catch (error) {
      // if (error is DioException) {
      //   EasyLoading.showToast('Network error: ${error.message}');
      if(isNeedToast){
        EasyLoading.showToast('请检查网络');
      }
      return ApiResponse(code: 500, msg: '请检查网络');
      // }
    }
  }
}
