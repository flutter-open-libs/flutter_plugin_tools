
class SingUtil {
  SingUtil._();

  /// 手机号中间4位 * 代替
  static String maskPhone(String phone)  {
    if(phone.length <= 2){
      return phone;
    }
    String phoneStr = phone.replaceFirst(RegExp(r'\d{4}'), '****', 3);
    return phoneStr;
  }
}
