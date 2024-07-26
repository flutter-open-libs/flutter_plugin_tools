class ApiListResponse<T> {
   dynamic list;
   int? page;
   int pageCount = 1;
   int? pageSize;
   int? totalCount;

  ApiListResponse({this.list, this.page, this.pageCount = 1, this.pageSize, this.totalCount});

  ApiListResponse.fromJson(Map<String, dynamic> json) {
    list = json['list'];
    page = json['page'];
    pageCount = json['page_count'] ?? 1;
    pageSize = json['page_size'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['list'] = this.list;
    data['page'] = this.page;
    data['page_count'] = this.pageCount;
    data['page_size'] = this.pageSize;
    data['total_count'] = this.totalCount;
    return data;
  }
}