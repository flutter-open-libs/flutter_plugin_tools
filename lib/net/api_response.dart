class ApiResponse<T> {
  int? code;
  String? msg;
  dynamic data;

  ApiResponse({this.code, this.msg, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if(json['data'] != null){
      data = json['data'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
