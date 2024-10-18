import 'package:get_storage/get_storage.dart';

// var token = SpUtil().token.val;
// SpUtil().token.val = 'xxxxxxxxxxxxxxxx';

class SpUtil {

  static var spKey = 'MyStorage';
  static  GetStorage _storage = GetStorage(spKey);

  static var IS_FIRST = 'is_first';
  static var IMEI = 'user_imei';
  static var OAID = 'user_oaid';
  static var TOKEN = 'user_token';
  static var PHONE = 'user_phone';
  static var CHANNEL_ID = 'user_channel_id';
  static var NET_PARAMS = 'net_params';
  static var FINISH_API_INFO = 'finish_api_Info'; // 是否完善了API产品的信息
  static var IDFA = 'ios_idfa'; // IOS设备ID

  static var IS_OPEN_PROXY = 'is_open_proxy'; // 是否开启代理
  static var PROXY_HOST = 'proxy_host';
  static var PROXY_PORT = 'proxy_port';
  static var BASE_URL = 'base_url'; // 当前环境
  static var PRO_URL = 'pro_url'; // 正式环境
  static var UAT_URL = 'uat_url'; // 测试环境
  static var DEV_URL = 'dev_url'; // 开发环境


  static void init(String key) async { 
    spKey = 'MyStorage';
    _storage = GetStorage(spKey);
  }

//// 通用方法 /////////////////////////////////////
  // 保存数据
  static void write(String key, dynamic value) {
    _storage.write(key, value);
  }

  static dynamic read(String key, dynamic defaultValue) {
    if(_storage.hasData(key)){
      return _storage.read(key);
    }
    return defaultValue;
  }


  // 删除某key
  static void remove(String key) {
    _storage.remove(key);
  }

  static GetStorage getStorage() {
    return _storage;
  }

  // 测试监听，demo，不能直接调用，使用场景不多
  // void _test1() {
  //   var listen = _storage.listenKey("key", (value) {
  //     print('new key is $value');
  //   });
  // }
}
